import "package:flutter/material.dart";

class RepoTile extends StatelessWidget {
  const RepoTile({
    Key key,
    @required this.name,
    this.description,
    @required this.stars,
    this.language,
  }) : super(key: key);

  final String name;
  final String description;
  final int stars;
  final String language;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8.0),
          description != null
              ? Text(description)
              : Text("No description provided."),
          SizedBox(height: 8.0),
          Text("★ $stars"),
        ],
      ),
      trailing: language != null ? Text(language) : SizedBox(),
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      onTap: () {},
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    Key key,
    this.avatarUrl,
    @required this.name,
  }) : super(key: key);

  final String avatarUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
        radius: 16.0,
      ),
      title: Text(name),
      dense: true,
      onTap: () {},
    );
  }
}

// TODO: ActivityTile

// TODO: IssueTile