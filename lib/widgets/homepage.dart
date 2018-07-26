import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final refresh;
  HomePage(this.refresh);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with ChangeNotifier {
  var list;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    random = Random();
    refreshList();
    widget.refresh.addListener(refreshList);
  }

  @override
  void dispose() {
    widget.refresh.removeListener(refreshList);
    super.dispose();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      list = List.generate(random.nextInt(20), (i) => "Item $i");
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pull to refresh"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        child: ListView.builder(
          itemCount: list?.length,
          itemBuilder: (context, i) => ListTile(
                title: Text(list[i]),
              ),
        ),
        onRefresh: refreshList,
      ),
    );
  }
}
