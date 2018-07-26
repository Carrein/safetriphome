import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'dart:async';
import 'dart:io';
import 'package:geolocation/geolocation.dart';

class PostHandler {
  String _url = "https://178.128.211.167";

  Future<String> post(_content, _id) async {
    var _username;
    var latitude;
    var longitude;
    var _value = "post successful 🙂";
    var _time = new DateTime.now().millisecondsSinceEpoch.toString();

    final prefs = await SharedPreferences.getInstance();
    if (prefs.get("username") != null) {
      _username = prefs.get("username");
    } else {
      _value = "unable to post, are you logged in? 😥";
      return _value;
    }

    final GeolocationResult result = await Geolocation.isLocationOperational();
    if (result.isSuccessful) {
      Geolocation
          .singleLocationUpdate(accuracy: LocationAccuracy.best)
          .listen((response) async {
        if (response.isSuccessful) {
          latitude = response.location.latitude.toString();
          longitude = response.location.longitude.toString();

          print(_username);
          print(_content);
          print(latitude);
          print(longitude);
          print(_time);

          Map<String, dynamic> postdata = {
            "user": _username,
            "content": _content,
            "timestamp": _time,
            "longitude": longitude.toString(),
            "latitude": latitude.toString(),
          };

          Map<String, dynamic> commentdata = {
            "user": _username,
            "content": _content,
            "postid": _id.toString(),
            "timestamp": _time,
          };

          HttpClient httpClient = new HttpClient()
            ..badCertificateCallback =
                ((X509Certificate cert, String host, int port) => true);
          IOClient ioClient = new IOClient(httpClient);

          if (_id == 0) {
            _url += "/post";
            await ioClient
                .post(_url, body: postdata)
                .whenComplete(() {})
                .catchError((e) {
              print(e.toString());
              _value = "an error occurred, the server could be down! 😥";
            });
          } else {
            _url += "/comment";
            print(_url);
            await ioClient
                .post(_url, body: commentdata)
                .whenComplete(() {})
                .catchError((e) {
              print(e.toString());
              _value = "an error occurred, the server could be down! 😥";
            });
          }
        } else {
          _value = "unable to get one shot location. 😥";
          return _value;
        }
      });
    } else {
      _value = "unable to access location, check your settings. 😥";
      return _value;
    }
    return _value;
  }
}
