import "package:json_annotation/json_annotation.dart";

part "project.g.dart";

/// Correspond Reponse JSON: https://github.com/huchenme/github-trending-api#trending-repositories
@JsonSerializable()
class Project {
  final String author;
  final String name;
  final String avatar;
  final String url;
  final String description;
  final String language;
  final String languageColor;
  final int stars;
  final int forks;
  final int currentPeriodStars;
  final List<BuiltBy> builtBy;

  Project(
    this.author,
    this.name,
    this.avatar,
    this.url,
    this.description,
    this.language,
    this.languageColor,
    this.stars,
    this.forks,
    this.currentPeriodStars,
    this.builtBy,
  );

  String get fullName => "$author/$name";

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  String toString() {
    return "Project($fullName, $avatar, $language)";
  }
}

@JsonSerializable()
class BuiltBy {
  final String avatar;
  final String username;

  BuiltBy(this.avatar, this.username);

  factory BuiltBy.fromJson(Map<String, dynamic> json) =>
      _$BuiltByFromJson(json);

  Map<String, dynamic> toJson() => _$BuiltByToJson(this);
}
