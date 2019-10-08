import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:github/server.dart';

import 'package:gitme_reborn/components/github_login_form.dart';
import 'package:gitme_reborn/services/github_api.dart';
import 'package:gitme_reborn/stores/account.dart';
import 'package:gitme_reborn/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var account = Provider.of<AccountModel>(context);

    return ProgressHUD(
      backgroundColor: Colors.black87,
      textStyle: Theme.of(context).accentTextTheme.subtitle,
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(FlutterI18n.translate(context, "login.login")),
          ),
          body: SingleChildScrollView(
            child: GithubLoginForm(
              onLogin: (state) {
                if (state.formKey.currentState.validate()) {
                  final progress = ProgressHUD.of(context);
                  progress.showWithText("Loading...");
                  FocusScope.of(context).requestFocus(new FocusNode());
                  Future.delayed(Duration(milliseconds: 500), () async {
                    try {
                      githubClient = getGithubApiClient(
                        username: state.usernameController.text,
                        password: state.passwordController.text,
                      );
                      User currentUser =
                          await githubClient.users.getCurrentUser();
                      account.updateUser(currentUser);
                      showNotify(message: "Welcome ${currentUser.login} ~~");
                      Navigator.pushReplacementNamed(context, "/home");
                    } catch (e) {
                      showNotify(
                        message: "Uh oh, your username or password is wrong...",
                        type: NotifyType.error,
                      );
                    }
                    progress.dismiss();
                  });
                } else {
                  showNotify(
                    message: "Please enter required fields.",
                    type: NotifyType.warning,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
