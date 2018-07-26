import 'package:flutter/material.dart';
import '../helper/post_handler.dart';

class Post extends StatefulWidget {
  @override
  createState() => new _Post();
}

class _Post extends State<Post> {
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 80.0, horizontal: 60.0),
      child: new ListView(
        children: <Widget>[
          new TextField(
            decoration: new InputDecoration(
              labelText: "How are you feeling today?",
            ),
            //Modifiers.
            controller: _textController,
            onSubmitted: _handleSubmitted,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            maxLength: 1000,
            //Modifiers.
            onChanged: (String text) {
              setState(() {
                //Text must not be empty or comprise of solely whitespace.
                _isComposing = text.length > 0 && !(text.trim().length == 0);
              });
            },
          ),
          //Buttons are disabled if textfield is empty.
          new ButtonTheme.bar(
              child: new ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              new RaisedButton(
                child: new Icon(Icons.bubble_chart),
                //Modifiers.
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text) //modified
                    : null,
              ),
              new RaisedButton(
                child: new Icon(Icons.save_alt),
                //Modifiers.
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text) //modified
                    : null,
              )
            ],
          )),
        ],
      ),
    );
  }

  _handleSubmitted(_text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    PostHandler ph = new PostHandler();
    ph.post(_text, 0).then((response) {
      buildScaffold(response, Colors.red[200]);
    });
  }

  buildScaffold(val, color) {
    Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: color,
          duration: new Duration(seconds: 3),
          content: Text(val),
        ));
  }
}
