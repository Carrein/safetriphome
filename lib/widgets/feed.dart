import 'package:flutter/material.dart';
import 'dart:async';
import '../helper/feed_handler.dart';

class Feed extends StatefulWidget {
  @override
  _Feed createState() => new _Feed();
}

class _Feed extends State<Feed> {
  List<String> items = [];
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  int count = 1;
  final max = 10;
  FeedHandler fh = new FeedHandler();

  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getData() async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });

      List<String> newEntries = [];
      for(int i = 0; i < max; i++){
        await fh.feed(count).then((response){
          if(response != null){
            newEntries.add(response);
            count++;
          }
        });
      }

      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        items.addAll(newEntries);
        isPerformingRequest = false;
      });
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Infinite ListView"),
      ),
      body: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return _buildProgressIndicator();
          } else {
            return ListTile(title: new Text(items[index]));
          }
        },
        controller: _scrollController,
      ),
    );
  }
}
