import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Name *",
                  hintText: "Your Github account username",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  labelText: "Password *",
                  hintText: "Your Github account password or ...",
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
                  Navigator.pushReplacementNamed(context, "/home");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
