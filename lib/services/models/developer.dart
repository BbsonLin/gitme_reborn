import "package:json_annotation/json_annotation.dart";

part "developer.g.dart";

@JsonSerializable()
class Developer {
  final String username;
  final String name;
  final String type;
  final String url;
  final String avatar;
  final Repo repo;

  Developer(
    this.username,
    this.name,
    this.type,
    this.url,
    this.avatar,
    this.repo,
  );

  factory Developer.fromJson(Map<String, dynamic> json) =>
      _$DeveloperFromJson(json);

  Map<String, dynamic> toJson() => _$DeveloperToJson(this);
}

@JsonSerializable()
class Repo {
  final String name;

  Repo(this.name);

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  Map<String, dynamic> toJson() => _$RepoToJson(this);
}
