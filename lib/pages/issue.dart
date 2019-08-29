import 'package:flutter/material.dart';

class IssuePage extends StatelessWidget {
  final List issueList = [
    {
      "title": "Include additional log fields #1",
      "time": "11 days ago",
    },
    {
      "title": "AdPlayer Widget #1",
      "time": "3 months ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: issueList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(issueList[index]["title"]),
            subtitle: Text(issueList[index]["time"]),
            trailing: Icon(Icons.star),
            onTap: () {},
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.0),
      ),
    );
  }
}