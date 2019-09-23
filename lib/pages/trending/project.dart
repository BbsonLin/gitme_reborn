import "package:flutter/material.dart";
import 'package:gitme_reborn/components/github_trending_tiles.dart';
import 'package:gitme_reborn/services/github_trending_api.dart';
import 'package:gitme_reborn/services/models/project.dart';

class TrendingProjects extends StatefulWidget {
  @override
  _TrendingProjectsState createState() => _TrendingProjectsState();
}

class _TrendingProjectsState extends State<TrendingProjects> {
  Future<List<Project>> projectList;

  @override
  void initState() {
    super.initState();
    projectList = githubTrendingClient.listProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: projectList,
          builder:
              (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProjectTile(
                        name: snapshot.data[index].fullName,
                        description: snapshot.data[index].description,
                        stars: snapshot.data[index].stars,
                        currentStars: snapshot.data[index].currentPeriodStars,
                        language: snapshot.data[index].language,
                        languageColor: snapshot.data[index].languageColor,
                        builtBy: snapshot.data[index].builtBy,
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
            projectList = githubTrendingClient.listProjects();
          });
        },
      ),
    );
  }
}
