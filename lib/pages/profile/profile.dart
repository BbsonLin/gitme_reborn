import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'package:gitme_reborn/components/profile/profile_info.dart';
import 'package:gitme_reborn/pages/repo.dart';
import 'package:gitme_reborn/pages/profile/star.dart';
import 'package:gitme_reborn/pages/profile/follow.dart';
import 'package:gitme_reborn/stores/account.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var account = Provider.of<AccountModel>(context);
    
    return DefaultTabController(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(account.profile.login),
                pinned: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      ProfileInfo(
                        avatarUrl: account.profile.avatarUrl,
                        name: account.profile.name,
                        bio: account.profile.bio,
                        location: account.profile.location,
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
