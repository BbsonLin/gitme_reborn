import "package:flutter/material.dart";
import 'package:timeago/timeago.dart' as timeago;
import 'package:gitme_reborn/components/github_language_label.dart';

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
      trailing: GithubLanguageLabel(
        language: language,
      ),
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

class IssueTile extends StatelessWidget {
  const IssueTile({
    Key key,
    @required this.userAvatarUrl,
    @required this.title,
    @required this.createTime,
  }) : super(key: key);

  final String userAvatarUrl;
  final String title;
  final DateTime createTime;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(createTime);
    final createTimeAgo = timeago.format(now.subtract(difference));

    return ListTile(
      dense: true,
      leading: CircleAvatar(
        radius: 18.0,
        backgroundImage: NetworkImage(userAvatarUrl),
      ),
      title: Text(title),
      subtitle: Text(createTimeAgo),
      trailing: Icon(Icons.error_outline),
      onTap: () {},
    );
  }
}
