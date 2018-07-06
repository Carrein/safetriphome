import '../widgets/tile.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

class FeedHandler {
  final url = "https://178.128.211.167/post";

  Future<String> feed(count) async {
    String value;
    Map<String, String> data = {
      "var": count.toString(),
    };

    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(httpClient);
    await ioClient.get(url, headers: data).then((response) {
      if (response.body != "eol") {
        value = json.decode(response.body)["content"];
      }
    }).catchError((e) {
      print(e.toString());
    });
    return value;
  }
}
