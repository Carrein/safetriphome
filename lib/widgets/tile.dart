import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  String _content;
  Tile(_newContent){
    this._content = _newContent;
  }
  createState() => new _Tile(_content);
}

class _Tile extends State<Tile> {
  String _content;
  bool _isUpvoted = false;
  int _upvoteCount = 1231;

    _Tile(_newContent){
    this._content = _newContent;
  }

  _toggleUpvote() {
    setState(() {
      if (_isUpvoted) {
        //TODO - upvote count;
        _isUpvoted = false;
      } else {
        //TODO - upvote count;
        _isUpvoted = true;
      }
    });
  }

  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
            width: 80.0,
            child: new Column(
              children: <Widget>[
                new MaterialButton(
                  child: new Icon(Icons.arrow_drop_up, size: 40.0),
                  onPressed: () => null,
                ),
                new Center(
                  child: Text(_upvoteCount.toString()),
                )
                // new Text(_upvoteCount.toString()),
              ],
            ),
          ),
          new Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Text(_content),
              ],
            ),
          ),
          new Container(
            width: 80.0,
            child: new Column(
              children: <Widget>[
                new MaterialButton(
                  child: new Icon(Icons.thumb_up),
                  height: 40.0,
                  onPressed: () => null,
                ),
                new MaterialButton(
                  child: new Icon(Icons.short_text),
                  height: 40.0,
                  onPressed: () => null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}