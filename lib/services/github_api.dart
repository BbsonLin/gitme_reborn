import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github/server.dart';

GitHub githubClient;

GitHub getGithubApiClient({username, password, token}) {
  if (username != null && password != null) {
    return GitHub(auth: Authentication.basic(username, password));
  } else if (token != null) {
    return GitHub(
      auth: Authentication.withToken(
          DotEnv().env["GITHUB_PERSONAL_ACCESS_TOKEN"]),
    );
  } else {
    throw GitHubError(null, "Didn't provide auth info.");
    // return GitHub(auth: Authentication.anonymous());
  }
}
