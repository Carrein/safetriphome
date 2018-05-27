import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'widgets/post.dart';
import 'theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'widgets/feed.dart';

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
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new TabBarView(
        controller: _controller,
        children: [
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
        ],
      ),
    );
  }
}

// class InfiniteList extends StatefulWidget {
//   @override
//   createState() => new _InfiniteList();
// }

// class _InfiniteList extends State<InfiniteList> {
//   var _suggestions = <WordPair>[];
//   var refreshKey = GlobalKey<RefreshIndicatorState>();
//   // final refreshKey =

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   refreshList();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         key: refreshKey,
//         child: _buildSuggestions(),
//         onRefresh: refreshList,
//       ),
//     );
//   }

//   Future<Null> refreshList() async {
//     refreshKey.currentState?.show(atTop: false);
//     await Future.delayed(Duration(seconds: 2));

//     setState() {
//       return Scaffold(
//         body: RefreshIndicator(
//           key: refreshKey,
//           child: _buildSuggestions(),
//           onRefresh: refreshList,
//         ),
//       );
//     }

//     return null;
//   }

//   Widget _buildSuggestions() {
//     return new ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemBuilder: (context, i) {
//           if (i.isOdd) return new Divider();
//           final index = i ~/ 2;
//           if (index >= _suggestions.length) {
//             _suggestions.addAll(generateWordPairs().take(10));
//           }
//           return _buildRow(_suggestions[index]);
//         });
//   }

//   Widget _buildRow(WordPair pair) {
//     return new ListTile(
//       title: new Text(
//         pair.asPascalCase,
//         style: TextStyle(fontSize: 18.0),
//       ),
//     );
//   }
// }
