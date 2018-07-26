import 'dart:io';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import '../unit/unit.dart';

class FeedHandler {
  String _url = "https://178.128.211.167/feed";

  Future<List<Unit>> feed(distance, count, latitude, longitude) async {
    List<Unit> _value = [];
    dynamic _time = new DateTime.now().millisecondsSinceEpoch.toString();
    print(distance);
    print(count);

    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(httpClient);

    await ioClient.get(_url, headers: {
      "var": count.toString(),
      "dist": distance.toString(),
      "lat": latitude.toString(),
      "long": longitude.toString(),
      "current": _time,
    }).then((response) {
      if (response.body != "eol") {
        for (int i = 0; i < json.decode(response.body).length; i++) {
          var id = json.decode(response.body)[i]["id"];
          var content = json.decode(response.body)[i]["content"];
          var latitude = json.decode(response.body)[i]["latitude"];
          var longtitude = json.decode(response.body)[i]["longtitude"];
          var user = json.decode(response.body)[i]["user"];
          _value.add(Unit(id, latitude, longtitude, user, content));
        }
      } else {
        print("oob");
      }
    });

    return _value;
  }
}
