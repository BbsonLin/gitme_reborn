import "package:flutter/material.dart";
import 'package:github/server.dart';
import 'package:gitme_reborn/services/github_api.dart';

class RepoPage extends StatefulWidget {
  @override
  _RepoPageState createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  Future<List<Repository>> repoList;

  @override
  void initState() {
    super.initState();
    repoList = fetchRepos();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: repoList,
          builder:
              (BuildContext context, AsyncSnapshot<List<Repository>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                            "${snapshot.data[index].owner.login}/${snapshot.data[index].name}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 8.0),
                            snapshot.data[index].description != null
                                ? Text(snapshot.data[index].description)
                                : Text("No description provided."),
                            SizedBox(height: 8.0),
                            Text("★ ${snapshot.data[index].stargazersCount}"),
                          ],
                        ),
                        trailing: snapshot.data[index].language != null
                            ? Text(snapshot.data[index].language)
                            : SizedBox(),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        onTap: () {},
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
            repoList = fetchRepos();
          });
        },
      ),
    );
  }

  Future<List<Repository>> fetchRepos() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    return githubClient.repositories.listUserRepositories(user.login).toList();
  }
}
