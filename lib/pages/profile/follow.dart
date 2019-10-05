import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:github/server.dart';

import 'package:gitme_reborn/components/github_tiles.dart';
import 'package:gitme_reborn/stores/account.dart';
import 'package:gitme_reborn/utils.dart';

class FollowerPage extends StatefulWidget {
  @override
  _FollowerPageState createState() => _FollowerPageState();
} 

class _FollowerPageState extends State<FollowerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (BuildContext context, AccountModel account, Widget child) {
        if (account.followers == null) {
          account.fetchFollowers();
          return Center(child: CircularProgressIndicator());
        } else {
          return Scrollbar(
            child: RefreshIndicator(
              child: buildFollowerListView(account.followers),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                await account.refreshRepos();
                showNotify(message: "Refresh done");
              },
            ),
          );
        }
      },
    );
  }

  buildFollowerListView(List<User> followers) {
    return ListView.separated(
      padding: EdgeInsets.all(0.0),
      itemCount: followers.length,
      itemBuilder: (BuildContext context, int index) {
        return UserTile(
          avatarUrl: followers[index].avatarUrl,
          name: followers[index].login,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 0.0),
    );
  }
}

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (BuildContext context, AccountModel account, Widget child) {
        if (account.followings == null) {
          account.fetchFollowings();
          return Center(child: CircularProgressIndicator());
        } else {
          return Scrollbar(
            child: RefreshIndicator(
              child: buildFollowingListView(account.followings),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                await account.refreshRepos();
                showNotify(message: "Refresh done");
              },
            ),
          );
        }
      },
    );
  }

  buildFollowingListView(List<User> followings) {
    return ListView.separated(
      padding: EdgeInsets.all(0.0),
      itemCount: followings.length,
      itemBuilder: (BuildContext context, int index) {
        return UserTile(
          avatarUrl: followings[index].avatarUrl,
          name: followings[index].login,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 0.0),
    );
  }
}
