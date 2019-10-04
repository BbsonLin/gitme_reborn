import 'package:flutter/material.dart';
import 'package:github/server.dart';
import 'package:gitme_reborn/components/github_tiles.dart';
import 'package:gitme_reborn/services/github_api.dart';
import 'package:gitme_reborn/stores/account.dart';
import 'package:gitme_reborn/utils.dart';
import 'package:provider/provider.dart';

class IssuePage extends StatefulWidget {
  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (BuildContext context, account, Widget child) {
        if (account.issues == null) {
          account.fetchIssues();
          return Center(child: CircularProgressIndicator());
        } else {
          return Scrollbar(
            child: RefreshIndicator(
              child: buildIssueListView(account.issues),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                await account.refreshIssues();
                showNotify(message: "Refresh done");
              },
            ),
          );
        }
      },
    );
  }

  Future<List<Issue>> fetchIssues() async {
    return githubClient.issues.listAll(state: "all").toList();
  }

  ListView buildIssueListView(List<Issue> issues) {
    return ListView.separated(
      itemCount: issues.length,
      itemBuilder: (BuildContext context, int index) {
        return IssueTile(
          userAvatarUrl: issues[index].user.avatarUrl,
          title: issues[index].title,
          createTime: issues[index].createdAt,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 0.0),
    );
  }
}
