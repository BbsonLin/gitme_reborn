import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key key,
    this.icon,
    this.text = "",
    this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          icon,
          SizedBox(width: 24.0),
          Text(text),
        ],
      ),
      onTap: onPressed ?? () {},
    );
  }
}
