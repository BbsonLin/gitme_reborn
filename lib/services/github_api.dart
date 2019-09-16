import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github/server.dart';

GitHub githubClient = GitHub(
  auth: Authentication.withToken(DotEnv().env["GITHUB_PERSONAL_ACCESS_TOKEN"]),
);
