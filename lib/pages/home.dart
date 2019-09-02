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
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List hnTops = [
    {
      "by": "jammygit",
      "descendants": 18,
      "title": "Pre-industrial workers had a shorter workweek than today's",
    },
    {
      "by": "MaysonL",
      "descendants": 2,
      "title": "Help Advance the World with Advanced Linear Algebra",
    },
    {
      "by": "xenocratus",
      "descendants": 152,
      "title": "Thoughts on Rust Bloat",
    },
  ];

  final List hnNews = [
    {
      "by": "rbanffy",
      "descendants": 0,
      "title": "Lost Nuclear Material Resurfaces in Maryland",
    },
    {
      "by": "jakeprins",
      "descendants": 0,
      "title": "Find books that help you grow",
    },
    {
      "by": "atlasunshrugged",
      "descendants": 0,
      "title": "America's Depressing New Culture War",
    },
  ];

  final List ghTrends = [
    {
      "author": "lumen",
      "name": "lumen",
      "avatar": "https://github.com/lumen.png",
      "url": "https://github.com/lumen/lumen",
      "description":
          "An alternative BEAM implementation, designed for WebAssembly",
      "language": "Rust",
      "languageColor": "#dea584",
      "stars": 850,
      "forks": 21,
    },
    {
      "author": "outline",
      "name": "outline",
      "avatar": "https://github.com/outline.png",
      "url": "https://github.com/outline/outline",
      "description":
          "The fastest wiki and knowledge base for growing teams. Beautiful, feature rich, markdown compatible and open source.",
      "language": "JavaScript",
      "languageColor": "#f1e05a",
      "stars": 5342,
      "forks": 329,
    },
    {
      "author": "tophubs",
      "name": "TopList",
      "avatar": "https://github.com/tophubs.png",
      "url": "https://github.com/tophubs/TopList",
      "description":
          "今日热榜，一个获取各大热门网站热门头条的聚合网站，使用Go语言编写，多协程异步快速抓取信息，预览:https://www.printf520.com/hot.html",
      "language": "Go",
      "languageColor": "#00ADD8",
      "stars": 1960,
      "forks": 332,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView(
        children: <Widget>[
          ListTile(
            dense: true,
            title: Text("Hackernews Top"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(
            height: 0.0,
          ),
          ...buildHNTopStories(context),
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
          ...buildHNNewStories(context),
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
          ...buildGHTrends(context),
        ],
      ),
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2));
      },
    );
  }

  buildHNTopStories(BuildContext context) {
    return ListTile.divideTiles(
            context: context,
            tiles: hnTops.map((story) {
              return ListTile(
                title: Text(story["title"]),
                subtitle: Text(
                    "by ${story["by"]} | ${story["descendants"]} comments"),
                onTap: () {},
              );
            }).toList())
        .toList();
  }

  buildHNNewStories(BuildContext context) {
    return ListTile.divideTiles(
            context: context,
            tiles: hnNews.map((story) {
              return ListTile(
                title: Text(story["title"]),
                subtitle: Text(
                    "by ${story["by"]} | ${story["descendants"]} comments"),
                onTap: () {},
              );
            }).toList())
        .toList();
  }

  buildGHTrends(BuildContext context) {
    return ListTile.divideTiles(
            context: context,
            tiles: ghTrends.map((repo) {
              return ListTile(
                title: Text("${repo["author"]} / ${repo["name"]}"),
                subtitle: Text(
                    "${repo["language"]}   ${repo["stars"]}   ${repo["forks"]}"),
                onTap: () {},
              );
            }).toList())
        .toList();
  }
}
