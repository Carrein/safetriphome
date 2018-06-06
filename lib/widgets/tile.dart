import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final String text;
  final String time;
  final int value;
  
  @override
  Tile(this.text, this.time, this.value);

  _Tile createState() => new _Tile(text, time, value);
}

class _Tile extends State<Tile> {
  final String text;
  final String time;
  final int value;

  _Tile(this.text, this.time, this.value);

  @override
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
                new Text(value.toString()),
                new MaterialButton(
                  child: new Icon(Icons.arrow_drop_down, size: 40.0),
                  onPressed: () => null,
                ),
              ],
            ),
          ),
          new Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Text(text),
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