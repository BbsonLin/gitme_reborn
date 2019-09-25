import 'package:flutter/material.dart';
import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:gitme_reborn/components/circle_avatar_button.dart';
import 'package:gitme_reborn/components/drawer_tile.dart';
import 'package:gitme_reborn/pages/activity.dart';
import 'package:gitme_reborn/pages/issue.dart';
import 'package:gitme_reborn/pages/repo.dart';
import 'package:gitme_reborn/pages/search.dart';
import 'package:gitme_reborn/services/github_trending_api.dart';
import 'package:gitme_reborn/services/models/project.dart';
import 'package:gitme_reborn/utils.dart';

// 主頁面
class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          titleSpacing: 0.0,
          leading: CircleAvatarButton(
            avatarImage: NetworkImage(
              "https://avatars2.githubusercontent.com/u/18156421?s=400&u=1f91dcf74134827fde071751f95522845223ed6a&v=4",
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
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
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://avatars2.githubusercontent.com/u/18156421?s=400&u=1f91dcf74134827fde071751f95522845223ed6a&v=4",
                    ),
                  ),
                  onTap: () => Navigator.of(context).pushNamed("/profile"),
                ),
                otherAccountsPictures: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              DrawerTile(
                icon: Icon(Icons.trending_up),
                text: "Trending",
                onPressed: () => Navigator.of(context).pushNamed("/trending"),
              ),
              DrawerTile(
                icon: Icon(Icons.settings),
                text: "Setting",
                onPressed: () => Navigator.of(context).pushNamed("/setting"),
              ),
              DrawerTile(
                icon: Icon(Icons.info),
                text: "About",
                onPressed: () => Navigator.of(context).pushNamed("/about"),
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
  final HnpwaClient hnClient = HnpwaClient();
  List<FeedItem> _hnTops;
  List<FeedItem> _hnNews;
  List<Project> _ghTrends;

  @override
  void initState() {
    super.initState();
    fetchHNData();
    fetchGHTrends();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
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
              onTap: () => Navigator.of(context).pushNamed("/trending"),
            ),
            Divider(
              height: 0.0,
            ),
            ...buildGHTrends(context),
          ],
        ),
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1)).then((value) {
            fetchHNData();
            fetchGHTrends();
          });
        },
      ),
    );
  }

  Future fetchHNData() async {
    Feed hnNew = await hnClient.news();
    Feed hnNewest = await hnClient.newest();
    if (this.mounted) {
      setState(() {
        _hnTops = hnNew.items;
        _hnNews = hnNewest.items;
      });
    }
  }

  Future fetchGHTrends() async {
    List<Project> ghTrends = await githubTrendingClient.listProjects();
    if (this.mounted) {
      setState(() {
        _ghTrends = ghTrends;
      });
    }
  }

  buildHNTopStories(BuildContext context) {
    if (_hnTops == null) {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        )
      ];
    } else {
      return ListTile.divideTiles(
              context: context,
              tiles: _hnTops.sublist(0, 4).map((item) {
                return ListTile(
                  title: Text(item.title),
                  subtitle:
                      Text("by ${item.user} | ${item.commentsCount} comments"),
                  onTap: () => launchURL(item.url),
                );
              }).toList())
          .toList();
    }
  }

  buildHNNewStories(BuildContext context) {
    if (_hnNews == null) {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        )
      ];
    } else {
      return ListTile.divideTiles(
              context: context,
              tiles: _hnNews.sublist(0, 4).map((item) {
                return ListTile(
                  title: Text(item.title),
                  subtitle:
                      Text("by ${item.user} | ${item.commentsCount} comments"),
                  onTap: () => launchURL(item.url),
                );
              }).toList())
          .toList();
    }
  }

  buildGHTrends(BuildContext context) {
    if (_ghTrends == null) {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        )
      ];
    } else {
      return ListTile.divideTiles(
              context: context,
              tiles: _ghTrends.sublist(0, 4).map((project) {
                return ListTile(
                  title: Text("${project.fullName}"),
                  subtitle: Row(
                    children: <Widget>[
                      Text("${project.language}"),
                      SizedBox(width: 16.0),
                      Text("★ ${project.stars}"),
                    ],
                  ),
                  onTap: () {},
                );
              }).toList())
          .toList();
    }
  }
}
