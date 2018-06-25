import 'package:flutter/material.dart';
import 'widgets/post.dart';
import 'theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'widgets/feed.dart';
import 'widgets/login.dart';

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

class _MainPage extends State<MainPage> with TickerProviderStateMixin {
  TabController _controller;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new TabBarView(
        controller: _controller,
        children: [
          new Login(),
          new Feed(),
          new Post(),
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        onTap: (int value) {
          _controller.animateTo(value);
          setState(() {
            _tab = value;
          });
        },
        currentIndex: _tab,
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.add), title: new Text("trends")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.location_on), title: new Text("feed")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.location_on), title: new Text("feed")),
        ],
      ),
    );
  }
}
