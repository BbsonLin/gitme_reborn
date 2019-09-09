import "package:flutter/material.dart";

class ThemeOption extends StatelessWidget {
  const ThemeOption({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 42.0,
          height: 42.0,
          child: DecoratedBox(
            decoration: BoxDecoration(color: color),
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
