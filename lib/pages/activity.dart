import 'package:flutter/material.dart';
import 'package:github/server.dart';
import 'package:gitme_reborn/services/github_api.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final List actList = [
    {
      "title": "yyx990803 starred cyanzhong/apple-terminated-my-dev-account",
      "time": "4 days ago",
    },
    {
      "title": "LiangJunrong starred fex-team/styleguide",
      "time": "4 days ago",
    },
    {
      "title": "ethan-funny starred NLP-LOVE/ML-NLP",
      "time": "5 days ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: fetchActivities(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    itemCount: actList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(actList[index]["title"]),
                        subtitle: Text(actList[index]["time"]),
                        trailing: Icon(Icons.star),
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
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
        },
      ),
    );
  }

  Future<List> fetchActivities() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    return [];
  }
}
