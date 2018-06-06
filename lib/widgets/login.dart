import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  final logo = CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: 48.0,
    child: new Icon(
      Icons.whatshot,
      size: 60.0,
    ),
  );

  final user = TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: 'Username',
      contentPadding: new EdgeInsets.all(12.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  );

  final password = TextFormField(
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Password',
      contentPadding: new EdgeInsets.all(12.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  );

  final submit = Container(
    child: new ButtonTheme.bar(
      child: ButtonBar(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new FlatButton(
            child: new Text("login."),
            onPressed: () => null,
          ),
          new FlatButton(
            child: new Text("sign up."),
            onPressed: () => null,
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Center(
            child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 48.0, right: 48.0),
          children: <Widget>[
            logo,
            user,
            SizedBox(height: 16.0),
            password,
            submit,
          ],
        )));
  }
}
