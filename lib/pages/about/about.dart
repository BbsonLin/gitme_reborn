import "package:flutter/material.dart";

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: viewportConstraints.maxWidth,
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/gitme-reborn-logo.png"),
                          radius: 40.0,
                        ),
                        SizedBox(height: 8.0),
                        Text("gitme reborn",
                            style: Theme.of(context).textTheme.title),
                        SizedBox(height: 4.0),
                        Text("0.0.1",
                            style: Theme.of(context).textTheme.subtitle),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("Made by BbsonLin",
                            style: Theme.of(context).textTheme.caption),
                        Text("License MIT",
                            style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
