import "package:flutter/material.dart";
import 'package:gitme_reborn/utils.dart';

class GithubLanguageLabel extends StatefulWidget {
  const GithubLanguageLabel({
    Key key,
    this.language,
    this.languageHexColor,
  }) : super(key: key);

  final String language;
  final String languageHexColor;

  @override
  _GithubLanguageLabelState createState() => _GithubLanguageLabelState();
}

class _GithubLanguageLabelState extends State<GithubLanguageLabel> {
  String _labelHexCode;

  @override
  void initState() {
    super.initState();
    searchLanguageColorHexCode(widget.language).then((labelHexCode) {
      if (mounted) {
        setState(() {
          _labelHexCode = labelHexCode;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color labelColor;

    if (widget.languageHexColor != null) {
      labelColor = hexToColor(widget.languageHexColor);
    } else if (widget.language != null) {
      labelColor =
          _labelHexCode != null ? hexToColor(_labelHexCode) : Colors.black;
    }

    if (widget.language != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "● ",
            style: TextStyle(color: labelColor, fontSize: 24.0),
          ),
          Text(widget.language),
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
