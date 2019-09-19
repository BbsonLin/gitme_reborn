import "package:flutter/material.dart";
import 'package:gitme_reborn/components/profile/profile_info.dart';
import 'package:gitme_reborn/pages/repo.dart';
import 'package:gitme_reborn/pages/profile/star.dart';
import 'package:gitme_reborn/pages/profile/follow.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text("BbsonLin"),
                pinned: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      ProfileInfo(
                        avatarUrl:
                            "https://avatars2.githubusercontent.com/u/18156421?s=400&u=1f91dcf74134827fde071751f95522845223ed6a&v=4",
                        name: "Bobson Lin",
                        location: "New Taipei City, Taiwan",
                      ),
                    ],
                  ),
                ),
                bottom: TabBar(
                  labelPadding: EdgeInsets.zero,
                  tabs: <Widget>[
                    Tab(text: "Repos"),
                    Tab(text: "Stars"),
                    Tab(text: "Followers"),
                    Tab(text: "Following"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              RepoPage(),
              StarRepoPage(),
              FollowerPage(),
              FollowingPage(),
            ],
          ),
        ),
      ),
      length: 4,
    );
  }
}
