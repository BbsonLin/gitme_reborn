import 'package:flutter/material.dart';

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
              onPressed: () {},
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            Text("Repo"),
            Text("Activity"),
            Text("Issues"),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text("Bobson Lin"),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              ListTile(
                title: Text("Sign out"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/login");
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
