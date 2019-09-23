import "package:flutter/material.dart";
import 'package:gitme_reborn/components/github_trending_tiles.dart';
import 'package:gitme_reborn/services/github_trending_api.dart';
import 'package:gitme_reborn/services/models/developer.dart';

class TrendingDevelopers extends StatefulWidget {
  @override
  _TrendingDevelopersState createState() => _TrendingDevelopersState();
}

class _TrendingDevelopersState extends State<TrendingDevelopers> {
  Future<List<Developer>> developerList;

  @override
  void initState() {
    super.initState();
    developerList = githubTrendingClient.listDevelopers();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: developerList,
          builder: (BuildContext context, AsyncSnapshot<List<Developer>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DeveloperTile(
                        avatarUrl: snapshot.data[index].avatar,
                        name: snapshot.data[index].name,
                        nickName: snapshot.data[index].username,
                        repo: snapshot.data[index].repo,
                        onPressed: () {},
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
          setState(() {
            developerList = githubTrendingClient.listDevelopers();
          });
        },
      ),
    );
  }
}
