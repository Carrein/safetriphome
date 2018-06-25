import 'package:flutter/material.dart';
// import 'package:geolocation/geolocation.dart';
import '../helper/unit.dart';
// import '../helper/database.dart';

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
      child: new Column(
        children: <Widget>[
          new TextField(
            decoration: new InputDecoration(
              labelText: "How are you feeling today?",
            ),
            //Modifiers.
            controller: _textController,
            onSubmitted: _handleSubmitted,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            maxLength: 140,
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

  //This method handles the submission of the form.
  void _handleSubmitted(String text) {
    _textController.clear();
    var current = new DateTime.now();
    setState(() {
      _isComposing = false;
    });
    Scaffold.of(context).showSnackBar(new SnackBar(
      content:  new Text("$text @ $current"),
    ));
    //Creates new unit to encapsulate data.
    var unit = new Unit(text, 0, current);
    // new Database().post(unit);
  }
}
