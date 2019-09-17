import 'package:flutter/material.dart';
import 'package:github/server.dart';
import 'package:gitme_reborn/services/github_api.dart';
import 'package:timeago/timeago.dart' as timeago;

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
                      final now = DateTime.now();
                      final difference =
                          now.difference(snapshot.data[index].createdAt);
                      var createTimeAgo =
                          timeago.format(now.subtract(difference));

                      return ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          radius: 18.0,
                          backgroundImage:
                              NetworkImage(snapshot.data[index].user.avatarUrl),
                        ),
                        title: Text(snapshot.data[index].title),
                        subtitle: Text(createTimeAgo),
                        trailing: Icon(Icons.error_outline),
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
