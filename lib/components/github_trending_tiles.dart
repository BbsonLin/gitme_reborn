import "package:flutter/material.dart";
import 'package:gitme_reborn/services/models/developer.dart';
import 'package:gitme_reborn/utils.dart';
import 'package:gitme_reborn/services/models/project.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({
    Key key,
    @required this.name,
    this.description,
    @required this.stars,
    @required this.currentStars,
    this.language,
    this.languageColor,
    @required this.builtBy,
    @required this.onPressed,
  }) : super(key: key);

  final String name;
  final String description;
  final int stars;
  final int currentStars;
  final String language;
  final String languageColor;
  final List<BuiltBy> builtBy;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8.0),
          Text("★ $currentStars stars today"),
          SizedBox(height: 8.0),
          description != ""
              ? Text(description)
              : Text("No description provided."),
          SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Text("★ $stars"),
              SizedBox(width: 16.0),
              ...buildBuiltByList(builtBy),
            ],
          )
        ],
      ),
      trailing: language != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "● ",
                  style: TextStyle(
                      color: hexToColor(languageColor), fontSize: 24.0),
                ),
                Text(language),
              ],
            )
          : SizedBox(),
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      onTap: onPressed,
    );
  }

  List<Padding> buildBuiltByList(List<BuiltBy> builtByList) {
    List builtBys = builtByList.map((builtBy) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: CircleAvatar(
          radius: 10.0,
          backgroundImage: NetworkImage(builtBy.avatar),
        ),
      );
    }).toList();
    if (builtBys.length > 7) {
      return builtBys.sublist(0, 6);
    } else {
      return builtBys;
    }
  }
}

class DeveloperTile extends StatelessWidget {
  const DeveloperTile({
    Key key,
    @required this.avatarUrl,
    @required this.name,
    this.nickName,
    @required this.repo,
    @required this.onPressed,
  }) : super(key: key);

  final String avatarUrl;
  final String name;
  final String nickName;
  final Repo repo;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
        radius: 28.0,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name),
          Text(nickName, style: Theme.of(context).textTheme.caption),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8.0),
          Text("🔥 ${repo.name}"),
          SizedBox(height: 8.0),
          Text(repo.description, style: Theme.of(context).textTheme.caption),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      onTap: () {},
    );
  }
}
