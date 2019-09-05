import "package:flutter/material.dart";

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  final List followList = [
    {
      "avatarUrl":
          "https://avatars2.githubusercontent.com/u/18156421?s=400&u=1f91dcf74134827fde071751f95522845223ed6a&v=4",
      "name": "Bobson Lin",
    },
    {
      "avatarUrl":
          "https://avatars2.githubusercontent.com/u/18156421?s=400&u=1f91dcf74134827fde071751f95522845223ed6a&v=4",
      "name": "Bobson Lin",
    },
    {
      "avatarUrl":
          "https://avatars2.githubusercontent.com/u/18156421?s=400&u=1f91dcf74134827fde071751f95522845223ed6a&v=4",
      "name": "Bobson Lin",
    },
    {
      "avatarUrl":
          "https://avatars2.githubusercontent.com/u/18156421?s=400&u=1f91dcf74134827fde071751f95522845223ed6a&v=4",
      "name": "Bobson Lin",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: ListView.separated(
          padding: EdgeInsets.all(0.0),
          itemCount: followList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(followList[index]["avatarUrl"]),
                radius: 16.0,
              ),
              title: Text(followList[index]["name"]),
              dense: true,
              onTap: () {},
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 0.0),
        ),
        onRefresh: () async {
          return Future.delayed(Duration(seconds: 2), () {});
        },
      ),
    );
  }
}
