import 'package:flutter/material.dart';

class RepoPage extends StatefulWidget {
  @override
  _RepoPageState createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  final List repoList = [
    {
      "title": "BbsonLin/gitme_reborn",
      "description": "No description provided.\n\n★ 0",
      "lang": "● Dart"
    },
    {
      "title": "BbsonLin/ithome-ironman",
      "description": "No description provided.\n\n★ 0",
      "lang": ""
    },
    {
      "title": "BbsonLin/flask-request-logger",
      "description":
          "A Flask extension for recording requests and responses into database\n\n★ 3",
      "lang": "● Python"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
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
        onRefresh: () async {
          return Future.delayed(Duration(seconds: 2), () {
            setState(() {
              repoList.add({
                "title": "BbsonLin/new-item",
                "description": "",
                "lang": ""
              });
            });
          });
        },
      ),
    );
  }
}
