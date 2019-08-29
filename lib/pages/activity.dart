import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
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
    return Container(
      child: ListView.separated(
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
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.0),
      ),
    );
  }
}
