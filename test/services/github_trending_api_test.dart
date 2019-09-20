import 'package:flutter_test/flutter_test.dart';
import 'package:gitme_reborn/services/github_trending_api.dart';
import 'package:gitme_reborn/services/models/project.dart';
import 'package:gitme_reborn/services/models/developer.dart';

main() {
  group('Test GitHub trending APIs', () {
    test('Test method listProjects successfully', () async {
      final api = GitHubTrendingApiClient();

      expect(await api.listProjects(), isInstanceOf<List<Project>>());
    });

    test('Test method listDevelopers successfully', () async {
      final api = GitHubTrendingApiClient();

      expect(await api.listDevelopers(), isInstanceOf<List<Developer>>());
    });
  });
}