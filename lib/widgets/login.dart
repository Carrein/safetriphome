import 'package:flutter/material.dart';
import '../helper/login_handler.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _Login createState() => new _Login();
}

enum FormType { login, register }

class _Login extends State<Login> {
  static final _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  final TextEditingController _validPassController =
      new TextEditingController();
  bool _enabled = true;
  FormType _formType = FormType.login;
  String _username;
  String _password;
  String _validPassword;
  LoginHandler _loginHandler = new LoginHandler();

  bool validate() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_formType == FormType.login) {
        toggle();
        return true;
      }
      if (_formType == FormType.register) {
        if (_password == _validPassword) {
          toggle();
          return true;
        } else {
          buildScaffold("password do not match 😰", Colors.orange[200]);
          return false;
        }
      }
    }
    return false;
  }

  toggle() {
    setState(() {
      _enabled = !_enabled;
    });
  }

  submit() {
    if (validate()) {
      if (_formType == FormType.login) {
        _loginHandler.login(_username, _password).then((val) {
          toggle();
          if (val) {
            clearFields();
            buildScaffold(
                "login as $_username successfully 🙂", Colors.green[200]);
            // Navigator.pop(context);
          } else {
            buildScaffold(
                "hmm, wrong username/password, try again 😥", Colors.red[200]);
          }
        });
      } else {
        _loginHandler.register(_username, _password).then((val) {
          toggle();
          if (val) {
            clearFields();
            buildScaffold(
                "signup as $_username successfully 🙂", Colors.green[200]);
            // Navigator.pop(context);
          } else {
            clearFields();
            buildScaffold(
                "username already exists, try again 🤐", Colors.orange[200]);
          }
        });
      }
    }
  }

  clearFields() {
    _userController.clear();
    _passController.clear();
    _validPassController.clear();
  }

  buildScaffold(val, color) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: color,
      duration: new Duration(seconds: 3),
      content: Text(val),
    ));
  }

  moveToRegister() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      clearFields();
    });
  }

  moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      clearFields();
    });
  }

  /// Main logo (hero) for the login page.
  List<Widget> hero() {
    return [
      CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 30.0,
        child: new Icon(
          Icons.whatshot,
          size: 30.0,
        ),
      )
    ];
  }

  List<Widget> fields() {
    switch (_formType) {
      /**
       * fields:
       * username.
       * password.
       */
      case FormType.login:
        return [
          TextFormField(
            keyboardType: TextInputType.text,
            autocorrect: false,
            controller: _userController,
            validator: (val) {
              if (val.isEmpty) {
                return "username cannot be empty";
              }
              if (val.length < 6) {
                return "username must be longer than 6 characters";
              }
            },
            onSaved: (val) => _username = val,
            inputFormatters: [
              BlacklistingTextInputFormatter(
                new RegExp('[\\ ]'),
              ),
              LengthLimitingTextInputFormatter(20),
            ],
            decoration: InputDecoration(
              hintText: "username",
              contentPadding: new EdgeInsets.all(10.0),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            autocorrect: false,
            controller: _passController,
            validator: (val) {
              if (val.isEmpty) {
                return "password cannot be empty";
              }
              if (val.length < 6) {
                return "password must be longer than 6 characters";
              }
            },
            onSaved: (val) => _password = val,
            inputFormatters: [
              BlacklistingTextInputFormatter(
                new RegExp('[\\ ]'),
              ),
              LengthLimitingTextInputFormatter(20),
            ],
            decoration: InputDecoration(
              hintText: "password",
              contentPadding: new EdgeInsets.all(10.0),
            ),
          ),
        ];
      /**
       * fields:
       * new username.
       * new password.
       * reeneter password.
       */
      case FormType.register:
        return [
          TextFormField(
            keyboardType: TextInputType.text,
            autocorrect: false,
            controller: _userController,
            validator: (val) {
              if (val.isEmpty) {
                return "username cannot be empty";
              }
              if (val.length < 6) {
                return "username must be longer than 6 characters";
              }
            },
            onSaved: (val) => _username = val,
            inputFormatters: [
              BlacklistingTextInputFormatter(
                new RegExp('[\\ ]'),
              ),
              LengthLimitingTextInputFormatter(20),
            ],
            decoration: InputDecoration(
              hintText: "username",
              contentPadding: new EdgeInsets.all(10.0),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            autocorrect: false,
            controller: _passController,
            validator: (val) {
              if (val.isEmpty) {
                return "password cannot be empty";
              }
              if (val.length < 6) {
                return "password must be longer than 6 characters";
              }
            },
            onSaved: (val) => _password = val,
            inputFormatters: [
              BlacklistingTextInputFormatter(
                new RegExp('[\\ ]'),
              ),
              LengthLimitingTextInputFormatter(20),
            ],
            decoration: InputDecoration(
              hintText: "password",
              contentPadding: new EdgeInsets.all(10.0),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            autocorrect: false,
            controller: _validPassController,
            validator: (val) {
              if (val.isEmpty) {
                return "password cannot be empty";
              }
              if (val.length < 6) {
                return "password must be longer than 6 characters";
              }
            },
            onSaved: (val) => _validPassword = val,
            inputFormatters: [
              BlacklistingTextInputFormatter(
                new RegExp('[\\ ]'),
              ),
              LengthLimitingTextInputFormatter(20),
            ],
            decoration: InputDecoration(
              hintText: "reenter password",
              contentPadding: new EdgeInsets.all(10.0),
            ),
          )
        ];
      default:
        return null;
    }
  }

  List<Widget> buttons() {
    switch (_formType) {
      /**
       * buttons:
       * login.
       * register a new account.
       */
      case FormType.login:
        return [
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  new RaisedButton(
                    child: new Text("login"),
                    onPressed: _enabled ? submit : null,
                  ),
                  new RaisedButton(
                    child: new Text("register?"),
                    onPressed: moveToRegister,
                  ),
                ],
              ),
            ),
          ),
        ];
      /**
       * buttons:
       * register.
       * login with an account.
       */
      case FormType.register:
        return [
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  new RaisedButton(
                    child: new Text("register"),
                    onPressed: _enabled ? submit : null,
                  ),
                  new RaisedButton(
                    child: new Text("login?"),
                    onPressed: moveToLogin,
                  ),
                ],
              ),
            ),
          ),
        ];
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Center(
          child: new ListView(
            padding: new EdgeInsets.symmetric(vertical: 80.0, horizontal: 60.0),
            children: hero() + fields() + buttons(),
          ),
        ),
      ),
    );
  }
}
