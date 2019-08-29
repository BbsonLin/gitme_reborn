import 'package:flutter/material.dart';
import 'package:gitme_reborn/components/drawer_tile.dart';
import 'package:gitme_reborn/pages/activity.dart';
import 'package:gitme_reborn/pages/issue.dart';
import 'package:gitme_reborn/pages/repo.dart';
import 'package:gitme_reborn/pages/search.dart';

// 主頁面
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(text: "Home"),
              Tab(text: "Repo"),
              Tab(text: "Activity"),
              Tab(text: "Issues"),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: GitmeRebornSearchDelegate(),
                );
              },
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            RepoPage(),
            ActivityPage(),
            IssuePage(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                accountName: Text("Bbson Lin"),
                accountEmail: Text("bobson801104@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://avatars2.githubusercontent.com/u/18156421?s=400&u=1f91dcf74134827fde071751f95522845223ed6a&v=4",
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  Icon(Icons.edit, color: Colors.white),
                ],
              ),
              DrawerTile(
                icon: Icon(Icons.trending_up),
                text: "Trending",
                onPressed: () {
                  print("Head to Trending Page");
                },
              ),
              DrawerTile(
                icon: Icon(Icons.settings),
                text: "Setting",
                onPressed: () {
                  print("Head to Setting Page");
                },
              ),
              DrawerTile(
                icon: Icon(Icons.info),
                text: "About",
                onPressed: () {
                  print("Head to About Page");
                },
              ),
              DrawerTile(
                icon: Icon(Icons.power_settings_new),
                text: "Sign out",
                onPressed: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      content: Text("Are you sure to exit current account."),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context, "/login", ModalRoute.withName('/')),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 首頁
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            child: Divider(
              height: 8.0,
              color: Colors.grey[200],
            ),
            color: Colors.grey[200],
          ),
          ListTile(
            dense: true,
            title: Text("Hackernews Top"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            title: Text(
                "Pre-industrial workers had a shorter workweek than today's"),
            subtitle: Text("by jammygit 2 hours ago | 18 comments"),
            onTap: () {},
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            title: Text("Help Advance the World with Advanced Linear Algebra"),
            subtitle: Text("by MaysonL 1 hour ago | 2 comments"),
            onTap: () {},
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            title: Text("Thoughts on Rust Bloat"),
            subtitle: Text("by xenocratus 7 hours ago | 152 comments"),
            onTap: () {},
          ),
          Container(
            child: Divider(
              height: 8.0,
              color: Colors.grey[200],
            ),
            color: Colors.grey[200],
          ),
          ListTile(
            dense: true,
            title: Text("Hackernews New"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            title: Text(
                "Pre-industrial workers had a shorter workweek than today's"),
            subtitle: Text("by jammygit 2 hours ago | 18 comments"),
            onTap: () {},
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            title: Text("Help Advance the World with Advanced Linear Algebra"),
            subtitle: Text("by MaysonL 1 hour ago | 2 comments"),
            onTap: () {},
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            title: Text("Thoughts on Rust Bloat"),
            subtitle: Text("by xenocratus 7 hours ago | 152 comments"),
            onTap: () {},
          ),
          Container(
            child: Divider(
              height: 8.0,
              color: Colors.grey[200],
            ),
            color: Colors.grey[200],
          ),
          ListTile(
            dense: true,
            title: Text("Github Trending"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            title: Text("CorentinJ / Real-Time-Voice-Cloning"),
            subtitle: Text("Python   3,795   446"),
            onTap: () {},
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            title: Text("google / mediapipe"),
            subtitle: Text("C++   1,505   201"),
            onTap: () {},
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            title: Text("MisterBooo / LeetCodeAnimation"),
            subtitle: Text("Java   38,443   6,483"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
