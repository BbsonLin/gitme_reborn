import 'package:flutter/material.dart';
import 'package:github/server.dart';
import 'package:gitme_reborn/components/github_tiles.dart';
import 'package:gitme_reborn/services/github_api.dart';

enum SearchTypes {
  repos,
  users,
}

// Use(Extends) SearchDelegate for Search Page
class GitmeRebornSearchDelegate extends SearchDelegate {
  SearchTypes _searchType = SearchTypes.repos;

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
      PopupMenuButton(
        onSelected: (SearchTypes type) {
          _searchType = type;
          showSuggestions(context);
        },
        itemBuilder: (BuildContext context) {
          return [
            CheckedPopupMenuItem<SearchTypes>(
              value: SearchTypes.repos,
              checked: _searchType == SearchTypes.repos,
              child: const Text("Search Repos"),
            ),
            CheckedPopupMenuItem<SearchTypes>(
              value: SearchTypes.users,
              checked: _searchType == SearchTypes.users,
              child: const Text("Search Users"),
            ),
          ];
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResult(
      query: query,
      searchType: _searchType,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == "") {
      switch (_searchType) {
        case SearchTypes.repos:
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Search Repos",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).textSelectionColor,
                  ),
                ),
              ],
            ),
          );
        case SearchTypes.users:
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Search Users",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).textSelectionColor,
                  ),
                ),
              ],
            ),
          );
        default:
      }
    }
    return Center(
        child: Text(
            "Search ${_searchType.toString().split(".")[1]} that contain \"$query\" ..."));
  }
}

class SearchResult extends StatefulWidget {
  const SearchResult({
    Key key,
    this.query,
    this.searchType,
  }) : super(key: key);

  final String query;
  final SearchTypes searchType;

  @override
  _SearchRepoResultState createState() => _SearchRepoResultState();
}

class _SearchRepoResultState extends State<SearchResult> {
  Future<List> searchResultList;

  @override
  void initState() {
    super.initState();
    switch (widget.searchType) {
      case SearchTypes.repos:
        searchResultList = searchRepos(widget.query);
        break;
      case SearchTypes.users:
        searchResultList = searchUsers(widget.query);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: searchResultList,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      switch (widget.searchType) {
                        case SearchTypes.repos:
                          return RepoTile(
                            name:
                                "${snapshot.data[index].owner.login}/${snapshot.data[index].name}",
                            description: snapshot.data[index].description,
                            stars: snapshot.data[index].stargazersCount,
                            language: snapshot.data[index].language,
                          );
                        case SearchTypes.users:
                          return UserTile(
                            avatarUrl: snapshot.data[index].avatarUrl,
                            name: snapshot.data[index].login,
                          );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 0.0),
                  );
                } else {
                  return Center(child: Text("No Data"));
                }
                break;
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
            }
          },
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          switch (widget.searchType) {
            case SearchTypes.repos:
              setState(() {
                searchResultList = searchRepos(widget.query);
              });
              break;
            case SearchTypes.users:
              setState(() {
                searchResultList = searchUsers(widget.query);
              });
              break;
          }
        },
      ),
    );
  }

  Future<List<Repository>> searchRepos(String searchQuery) async {
    return githubClient.search.repositories(searchQuery, pages: 1).toList();
  }

  Future<List<User>> searchUsers(String searchQuery) async {
    return githubClient.search.users(searchQuery, pages: 1).toList();
  }
}
