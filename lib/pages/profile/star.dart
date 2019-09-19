import "package:flutter/material.dart";
import 'package:github/server.dart';
import 'package:gitme_reborn/components/github_tiles.dart';
import 'package:gitme_reborn/services/github_api.dart';

class StarRepoPage extends StatefulWidget {
  @override
  _StarRepoPageState createState() => _StarRepoPageState();
}

class _StarRepoPageState extends State<StarRepoPage> {
  Future<List<Repository>> starRepoList;

  @override
  void initState() {
    super.initState();
    starRepoList = fetchStarRepos();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: starRepoList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RepoTile(
                        name:
                            "${snapshot.data[index].owner.login}/${snapshot.data[index].name}",
                        description: snapshot.data[index].description,
                        stars: snapshot.data[index].stargazersCount,
                        language: snapshot.data[index].language,
                      );
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
          setState(() {
            starRepoList = fetchStarRepos();
          });
        },
      ),
    );
  }

  Future<List<Repository>> fetchStarRepos() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    List jsonResult = await githubClient.getJSON(
      "/users/${user.login}/starred",
      params: {"pages": "1"},
    );
    List<Repository> starRepos = jsonResult.map((star) {
      return Repository.fromJSON(star);
    }).toList();
    return starRepos;
  }
}
