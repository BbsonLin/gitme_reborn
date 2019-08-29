import 'package:flutter/material.dart';

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
    return SearchRepoResult();
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
    return Center(child: Text("Search for $query ..."));
  }
}

class SearchRepoResult extends StatelessWidget {
  final List repoList = [
    {
      "title": "flutterchina/gitme",
      "description": "Flutter开发的一款Github客户端。 A Github client APP developed with Flutter, and It both supports Android and iOS.\n\n★ 975",
      "lang": ""
    },
    {
      "title": "imsun/gitment",
      "description":
          "A comment system based on GitHub Issues.\n\n★ 3.5k",
      "lang": "● JavaScript"
    },
    {
      "title": "BbsonLin/gitme_reborn",
      "description": "No description provided.\n\n★ 0",
      "lang": "● Dart"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: repoList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(repoList[index]["title"]),
            subtitle: Text(repoList[index]["description"]),
            trailing: Text(repoList[index]["lang"]),
            isThreeLine: true,
            contentPadding: EdgeInsets.all(16.0),
            onTap: () {},
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 0.0),
      ),
    );
  }
}
