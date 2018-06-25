import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class LoginHandler {
  //Helper method to append mock email to pass Firebase Authentication requirements.
  String appendEmail(value) {
    return value + "@ruby.com";
  }

  Future<bool> login(_username, _password) async {
    bool _value;
    var _email = appendEmail(_username); //Mock email.
    final prefs = await SharedPreferences.getInstance();

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .whenComplete(() {
      FirebaseAuth.instance.currentUser().then((user) {
        prefs.setString("username", user.uid);
      });
      _value = true;
    }).catchError((e) {
      _value = false;
    });

    print(prefs.getString("username"));
    return _value;
  }

  Future<bool> register(_username, _password) async {
    bool _value;
    var _email = appendEmail(_username); //Mock email.
    final prefs = await SharedPreferences.getInstance();

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .whenComplete(() {
      FirebaseAuth.instance.currentUser().then((user) {
        prefs.setString("username", user.uid);
      });
      _value = true;
    }).catchError((e) {
      _value = false;
    });

    print(prefs.getString("username"));
    return _value;
  }
}

// class LoginHandler {
//   //This method checks if the user already has a login token.
//   void check() async {
//     // final prefs = await SharedPreferences.getInstance();
//     // final username = prefs.getString("username") ?? false;
//     // final password = prefs.getString("password") ?? false;
//     //if username and password exists.
//     // if (username && password) {
//     var url = "https://178.128.211.167";
//     HttpClient httpClient = new HttpClient()
//       ..badCertificateCallback =
//           ((X509Certificate cert, String host, int port) => true);
//     http.IOClient ioClient = new http.IOClient(httpClient);
//     ioClient.get(url).then((response) {
//       print("Response status: ${response.statusCode}");
//       print("Response body: ${response.body}");
//     });
//   }

//   /*
//   This method will perform the following:
//   a) If the username already exists. If true, reject the user.
//   b) Write the new login information to sharedprefences.
//   c) Write the new login information to db.
//   */
//   void signup(username, password) async {
//     if (true && false) {
//       //check db
//     }

//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("username", username);
//     prefs.setString("password", password);
//     // try{
//     // FirebaseUser user  = await FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: password);
//     // print ("Signed in ${user.uid}");
//     // }
//     // catch(e){
//     //   print("Error: $e");
//     // }
//     try {
//       FirebaseUser user = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: username, password: password);
//       print("Registered in ${user.uid}");
//     } catch (e) {
//       print("Error: $e");
//     }
//     // try {
//     //   FirebaseUser user = await FirebaseAuth.instance
//     //       .signInWithCustomToken(email: username, password: password);
//     //   print("Registered in ${user.uid}");
//     // } catch (e) {
//     //   print("Error: $e");
//     // }
//   }

//   /*
//   This method will perform the following:
//   a) Check if the login information matches the one on db.
//   b) If true, authenticate user and rewrite sharedprefences.
//   */
//   void login(username, password) {}

//   // Future<http.Response> fetchPost(){
//   //   return http.get('http://localhost:4567');
//   // }
//   void fetchPost() {
//     http.get('http://10.0.2.2:4567');
//   }
// }
