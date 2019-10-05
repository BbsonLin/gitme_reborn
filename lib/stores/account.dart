import 'package:flutter/foundation.dart';
import 'package:github/server.dart';
import 'package:gitme_reborn/services/github_api.dart';

class AccountModel extends ChangeNotifier {
  CurrentUser _user;
  List<Repository> _repos;
  List<Issue> _issues;
  List<Repository> _stars;
  List<User> _followers;
  List<User> _followings;

  CurrentUser get profile => _user;
  List<Repository> get repos => _repos;
  List<Issue> get issues => _issues;
  List<Repository> get stars => _stars;
  List<User> get followers => _followers;
  List<User> get followings => _followings;

  Future fetchRepos() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    _repos = await githubClient.repositories.listUserRepositories(user.login).toList();
    notifyListeners();
  }

  Future fetchIssues() async {
    _issues = await githubClient.issues.listAll(state: "all").toList();
    notifyListeners();
  }

  Future fetchStars() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    List jsonResult = await githubClient.getJSON(
      "/users/${user.login}/starred",
      params: {"pages": "1"},
    );
    _stars = jsonResult.map((star) {
      return Repository.fromJSON(star);
    }).toList();
    notifyListeners();
  }

  Future fetchFollowers() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    _followers = await githubClient.users.listUserFollowers(user.login).toList();
    notifyListeners();
  }

  Future fetchFollowings() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    List jsonResult = await githubClient.getJSON(
      "/users/${user.login}/following",
    );
    _followings = jsonResult.map((user) {
      return User.fromJson(user);
    }).toList();
    notifyListeners();
  }

  void updateUser(CurrentUser user) {
    _user = user;
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

  Future refreshStars() async {
    _stars = null;
    notifyListeners();

    await fetchStars();
    notifyListeners();
  }

  Future refreshFollowers() async {
    _followers = null;
    notifyListeners();

    await fetchFollowers();
    notifyListeners();
  }

  Future refreshFollowings() async {
    _followings = null;
    notifyListeners();

    await fetchFollowings();
    notifyListeners();
  }
}