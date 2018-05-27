import 'package:flutter/material.dart';
import 'tile.dart';
import 'dart:async';

class Feed extends StatefulWidget {
  @override
  createState() => new _Feed();
}

class _Feed extends State<Feed> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  var values = new List<String>();

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Home Page"),
      ),
      body: new RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: futureBuilder,
      ),
    );
  }

  Future<List<String>> _getData() async {
    values.add("Horses");
    values.add("Goats");
    values.add("Chickens");

    //Mock wait.
    // await Future.delayed(new Duration(seconds: 3));

    return values;
  }

  Future<Null> _handleRefresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    setState(() {
      // values.add("Strokes");
      // values.add("Julian");
      // values.add("Smith");
    });
    // await Future.delayed(new Duration(seconds: 3));
    return null;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new Tile("a","a"),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
}

//   Widget _tile(String text, String time) {
//     return new Align(
//       child: new Container(
//         // padding: EdgeInsets.all(5.0),
//         child: new Row(
//           children: <Widget>[
//             new Container(
//               width: 80.0,
//               child: new Column(
//                 children: <Widget>[
//                   new MaterialButton(
//                     child: new Icon(Icons.arrow_drop_up, size: 40.0),
//                     onPressed: () => null,
//                   ),
//                   new MaterialButton(
//                     child: new Icon(Icons.arrow_drop_down, size: 40.0),
//                     onPressed: () => null,
//                   ),
//                 ],
//               ),
//             ),
//             new Expanded(
//               child: new Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   new Text(
//                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque interdum rutrum sodales. Nullam mattis fermentum libero, non volutpat."),
//                 ],
//               ),
//             ),
//             new Container(
//               width: 80.0,
//               child: new Column(
//                 children: <Widget>[
//                   new MaterialButton(
//                     child: new Icon(Icons.thumb_up),
//                     height: 40.0,
//                     onPressed: () => null,
//                   ),
//                   new MaterialButton(
//                     child: new Icon(Icons.short_text),
//                     height: 40.0,
//                     onPressed: () => null,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
