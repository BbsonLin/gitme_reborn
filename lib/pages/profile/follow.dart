import "package:flutter/material.dart";
import 'package:github/server.dart';
import 'package:gitme_reborn/components/github_tiles.dart';
import 'package:gitme_reborn/services/github_api.dart';

class FollowerPage extends StatefulWidget {
  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  Future<List<User>> followerList;

  @override
  void initState() {
    super.initState();
    followerList = fetchFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: followerList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UserTile(
                        avatarUrl: snapshot.data[index].avatarUrl,
                        name: snapshot.data[index].login,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 0.0),
                  );
                } else {
                  return Center(child: Text("No Data"));
                }
                break;
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
            }
          },
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            followerList = fetchFollowers();
          });
        },
      ),
    );
  }

  Future<List<User>> fetchFollowers() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    return githubClient.users.listUserFollowers(user.login).toList();
  }
}

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  Future<List<User>> followingList;

  @override
  void initState() {
    super.initState();
    followingList = fetchFollowing();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: followingList,
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UserTile(
                        avatarUrl: snapshot.data[index].avatarUrl,
                        name: snapshot.data[index].login,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 0.0),
                  );
                } else {
                  return Center(child: Text("No Data"));
                }
                break;
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
            }
          },
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            followingList = fetchFollowing();
          });
        },
      ),
    );
  }

  Future<List<User>> fetchFollowing() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    List jsonResult = await githubClient.getJSON(
      "/users/${user.login}/following",
    );
    List<User> followingUsers = jsonResult.map((user) {
      return User.fromJson(user);
    }).toList();
    return followingUsers;
  }
}
