import "package:flutter/material.dart";
import 'package:gitme_reborn/components/profile/profile_info.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("BbsonLin"),
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ProfileInfo(
                      avatarUrl:
                          "https://avatars2.githubusercontent.com/u/18156421?s=400&u=1f91dcf74134827fde071751f95522845223ed6a&v=4",
                      name: "Bobson Lin",
                      location: "New Taipei City, Taiwan",
                    ),
                    SizedBox(height: 8.0),
                    TabBar(
                      labelPadding: EdgeInsets.zero,
                      tabs: <Widget>[
                        Tab(text: "Repos"),
                        Tab(text: "Stars"),
                        Tab(text: "Followers"),
                        Tab(text: "Following"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: <Widget>[
                  Text("Repos"),
                  Text("Stars"),
                  Text("Followers"),
                  Text("Following"),
                ],
              ),
            ),
          ],
        ),
      ),
      length: 4,
    );
  }
}
