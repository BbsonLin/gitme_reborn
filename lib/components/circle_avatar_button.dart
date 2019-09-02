import 'package:flutter/material.dart';

class CircleAvatarButton extends StatelessWidget {
  const CircleAvatarButton({
    Key key,
    this.padding = const EdgeInsets.all(12.0),
    @required this.avatarImage,
    @required this.onPressed,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final ImageProvider avatarImage;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkResponse(
        onTap: onPressed,
        child: Material(
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundImage: avatarImage,
          ),
        ),
        focusColor: Theme.of(context).focusColor,
        hoverColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        splashColor: Theme.of(context).splashColor,
      ),
    );
  }
}
