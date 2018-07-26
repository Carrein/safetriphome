import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'widgets/screen.dart';
import 'widgets/login.dart';
import 'widgets/post.dart';
import 'helper/preference_handler.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'safetriphome',
      theme: defaultTargetPlatform == TargetPlatform.iOS //new
          ? kIOSTheme //new
          : kDefaultTheme,
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  Choice _selectedChoice = choices[0];
  // PreferenceHandler ph = new PreferenceHandler();
  String _username = "Guest";

  @override
  initState() {
    super.initState();
    _setUser();
  }

  _setUser() {
    PreferenceHandler.exist("username").then((response) {
      if (response.isNotEmpty) {
        setState(() {
          _username = response;
        });
      }
    });
  }

  _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
      Navigator
          .push(
        context,
        MaterialPageRoute(builder: (context) => _selectedChoice.page),
      )
          .then((response) {
        setState(() {
          _setUser();
        });
      });
      _setUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    return Scaffold(
      appBar: AppBar(
        title: Text(_username),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        child: new Screen(),
      ),
    );
    // );
  }
}

class Choice {
  Choice({this.title, this.page});

  final String title;
  final Widget page;
}

List<Choice> choices = <Choice>[
  Choice(title: 'Login', page: new Login()),
  Choice(title: 'Contact', page: new Post()),
];
