import 'package:flutter/foundation.dart';
import 'package:github/server.dart';
import 'package:gitme_reborn/services/github_api.dart';

class AccountModel extends ChangeNotifier {
  CurrentUser _user;
  List<Repository> _repos;
  List<Issue> _issues;

  CurrentUser get profile => _user;
  List<Repository> get repos => _repos;
  List<Issue> get issues => _issues;

  Future fetchRepos() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    _repos = await githubClient.repositories.listUserRepositories(user.login).toList();
    notifyListeners();
  }

  Future fetchIssues() async {
    _issues = await githubClient.issues.listAll(state: "all").toList();
    notifyListeners();
  }

  void updateUser(CurrentUser user) {
    _user = user;
    notifyListeners();
  }

  void updateIssues(List<Issue> issues) {
    _issues = issues;
    notifyListeners();
  }

  Future refreshRepos() async {
    _repos = null;
    notifyListeners();

    await fetchRepos();
    notifyListeners();
  }

  Future refreshIssues() async {
    _issues = null;
    notifyListeners();

    await fetchIssues();
    notifyListeners();
  }
}