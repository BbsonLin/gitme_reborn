import 'package:flutter/material.dart';
import 'package:gitme_reborn/pages/trending/developer.dart';
import 'package:gitme_reborn/pages/trending/project.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: <Widget>[
              Tab(text: "Project"),
              Tab(text: "Developer"),
            ],
          ),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Date range: daily"),
                  ),
                ];
              },
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            TrendingProjects(),
            TrendingDevelopers(),
          ],
        ),
      ),
    );
  }
}
