import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tile.dart';
import 'dart:async';

class Feed extends StatefulWidget {
  @override
  createState() => new _Feed();
}

class _Feed extends State<Feed> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
            case ConnectionState.done:
            case ConnectionState.active:
            default:
              if (snapshot.hasError)
                return new Text("Error: ${snapshot.error}");
              else
                print("Creating view");
              return createListView(context, snapshot);
          }
        });

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("safetriphome"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        child: futureBuilder,
        onRefresh: refreshList,
      ),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    setState(() {
      build(context);
    });
    return null;
  }
}

Future<List<dynamic>> _getData() async {
  var values = new List<dynamic>();
  QuerySnapshot querySnapshot =
      await Firestore.instance.collection("posts").getDocuments();
  values = querySnapshot.documents.map((x) => x["content"]).toList();
  return values;
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<dynamic> values = snapshot.data;
  return new ListView.builder(
    itemCount: values.length,
    itemBuilder: (BuildContext context, int index) {
      return new Column(
        children: <Widget>[
          new Tile(values[index], "3", 22),
          new Divider(
            height: 2.0,
          ),
        ],
      );
    },
  );
}
