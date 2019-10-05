import "package:flutter/material.dart";
import 'package:github/server.dart';
import 'package:gitme_reborn/components/github_tiles.dart';
import 'package:gitme_reborn/stores/account.dart';
import 'package:gitme_reborn/utils.dart';
import 'package:provider/provider.dart';

class StarRepoPage extends StatefulWidget {
  @override
  _StarRepoPageState createState() => _StarRepoPageState();
}

class _StarRepoPageState extends State<StarRepoPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (BuildContext context, AccountModel account, Widget child) {
        if (account.stars == null) {
          account.fetchStars();
          return Center(child: CircularProgressIndicator());
        } else {
          return Scrollbar(
            child: RefreshIndicator(
              child: buildStarsListView(account.stars),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                await account.refreshStars();
                showNotify(message: "Refresh done");
              },
            ),
          );
        }
      },
    );
  }

  buildStarsListView(List<Repository> stars) {
    return ListView.separated(
      padding: EdgeInsets.all(0.0),
      itemCount: stars.length,
      itemBuilder: (BuildContext context, int index) {
        return RepoTile(
          name: "${stars[index].owner.login}/${stars[index].name}",
          description: stars[index].description,
          stars: stars[index].stargazersCount,
          language: stars[index].language,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 0.0),
    );
  }
}
