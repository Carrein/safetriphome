import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String text;
  final String time;

  Tile(this.text, this.time);

  @override
  Widget build(BuildContext context) {
    return _tile(text, time);
  }

  Widget _tile(String text, String time) {
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
                new Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque interdum rutrum sodales. Nullam mattis fermentum libero, non volutpat."),
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
