import "package:flutter/material.dart";
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String appVesion = "0.0.0";

  @override
  void initState() {
    super.initState();
    fetchAppVersion();
  }

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
                        Text(appVesion,
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

  Future fetchAppVersion() async {
    PackageInfo pacakgeInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVesion = pacakgeInfo.version;
    });
  }
}
