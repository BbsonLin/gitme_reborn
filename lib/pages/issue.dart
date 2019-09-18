import 'package:flutter/material.dart';
import 'package:github/server.dart';
import 'package:gitme_reborn/components/github_tiles.dart';
import 'package:gitme_reborn/services/github_api.dart';

class IssuePage extends StatefulWidget {
  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  Future<List<Issue>> issueList;

  @override
  void initState() {
    super.initState();
    issueList = fetchIssues();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: issueList,
          builder: (BuildContext context, AsyncSnapshot<List<Issue>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return IssueTile(
                        userAvatarUrl: snapshot.data[index].user.avatarUrl,
                        title: snapshot.data[index].title,
                        createTime: snapshot.data[index].createdAt,
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
            issueList = fetchIssues();
          });
        },
      ),
    );
  }

  Future<List<Issue>> fetchIssues() async {
    return githubClient.issues.listAll(state: "all").toList();
  }
}
