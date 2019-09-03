import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

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
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Name *",
                      hintText: "Your Github account username",
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: TextFormField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: _obscureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      labelText: "Password *",
                      hintText: "Your Github account password",
                    ),
                  ),
                ),
                SizedBox(
                  height: 52.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48.0,
                  height: 48.0,
                  child: RaisedButton(
                    child: Text("Login"),
                    onPressed: () {
                      final progress = ProgressHUD.of(context);
                      progress.showWithText("Loading...");
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pushReplacementNamed(context, "/home");
                        progress.dismiss();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
