import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github/server.dart';
import 'package:gitme_reborn/components/github_login_form.dart';
import 'package:gitme_reborn/services/github_api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      backgroundColor: Colors.black87,
      textStyle: Theme.of(context).accentTextTheme.subtitle,
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Login"),
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
                      Fluttertoast.showToast(
                        msg: "Welcome ${currentUser.login} ~~",
                        toastLength: Toast.LENGTH_LONG,
                      );
                      Navigator.pushReplacementNamed(context, "/home");
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "Uh oh, your username or password is wrong...",
                        toastLength: Toast.LENGTH_LONG,
                        textColor: Colors.black38,
                        backgroundColor: Colors.deepOrange[300],
                      );
                    }
                    progress.dismiss();
                  });
                } else {
                  Fluttertoast.showToast(
                    msg: "Please enter required fields.",
                    toastLength: Toast.LENGTH_LONG,
                    textColor: Colors.black38,
                    backgroundColor: Colors.amber,
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
