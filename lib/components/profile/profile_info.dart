import "package:flutter/material.dart";

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key key,
    @required this.avatarUrl,
    @required this.name,
    this.bio,
    this.location,
  }) : super(key: key);

  final String avatarUrl;
  final String name;
  final String bio;
  final String location;

  @override
  Widget build(BuildContext context) {
    TextTheme _primaryTextTheme = Theme.of(context).primaryTextTheme;

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 36.0,
          backgroundImage: NetworkImage(avatarUrl),
        ),
        SizedBox(height: 8.0),
        Text(
          name,
          style: _primaryTextTheme.subtitle,
        ),
        SizedBox(height: 6.0),
        Text(
          bio ?? "No bio yet",
          style: _primaryTextTheme.body1,
        ),
        SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: _primaryTextTheme.caption.fontSize,
              color: _primaryTextTheme.caption.color,
            ),
            SizedBox(width: 4.0),
            Text(
              location,
              style: _primaryTextTheme.caption,
            ),
          ],
        ),
      ],
    );
  }
}
