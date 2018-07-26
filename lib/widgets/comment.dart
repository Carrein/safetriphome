import 'package:flutter/material.dart';
import '../helper/post_handler.dart';
import '../unit/unit.dart';

class Comment extends StatefulWidget {
  Unit unit;
  Comment(this.unit);

  @override
  _Comment createState() => new _Comment(unit);
}

class _Comment extends State<Comment> {
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  Unit unit;
  _Comment(this.unit);

  Widget _header() {
    return new Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(10.0),
      child: Text(
        unit.content,
        style: new TextStyle(
          // fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _footer() {
    return new Expanded(
      child: new ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            height: 30.0,
            child: Text("data"),
          );
        },
      ),
    );
  }

  Widget _commentfield() {
    return new Container(
      color: Colors.grey[200],
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              maxLines: null,
              decoration: new InputDecoration(
                hintText: 'join the fray',
              ),
              onChanged: (String text) {
                setState(() {
                  //Text must not be empty or comprise of solely whitespace.
                  _isComposing = text.length > 0 && !(text.trim().length == 0);
                });
              },
            ),
          ),
          RaisedButton(
            child: new Icon(Icons.subdirectory_arrow_left),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  _handleSubmitted(_text) {
    _textController.clear();
    // setState(() {
    //   _isComposing = false;
    // });
    // PostHandler ph = new PostHandler();
    // ph.post(_text, unit.id).then((response) {
    //   response ? print("ok") : print("not ok");
    //   // val
    //   //     ? buildScaffold("comment successful 🙂", Colors.green[200])
    //   //     : buildScaffold(
    //   //         "an error occurred, are you logged in? 😥", Colors.red[200]);
    // });
  }

  // buildScaffold(val, color) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //         backgroundColor: color,
  //         duration: new Duration(seconds: 3),
  //         content: Text(val),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new Column(
              children: <Widget>[
                _header(),
                _footer(),
              ],
            ),
          ),
          _commentfield(),
        ],
      ),
    );
  }
}
