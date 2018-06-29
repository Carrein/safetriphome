import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';

class PostHandler {
  final url = "https://178.128.211.167";

  Future<bool> post(_content) async {
    final prefs = await SharedPreferences.getInstance();
    bool _value;
    Map<String, dynamic> data = {
      "id": prefs.getString("username"),
      "content": _content,
      "location": "123",
    };
    
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(httpClient);
    await ioClient.post(url, body: data).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    }).whenComplete(() {
      _value = true;
    }).catchError((e) {
      _value = false;
    });
    return _value;

    // Options options = new Options(
    //   baseUrl: url,
    // );
    // Dio dio = new Dio(options);

    // Response response = await dio.post("/post", data: {
    //   "id": prefs.getString("username"),
    //   "content": _content,
    //   //Arbitary location;
    //   "location": "123",
    // }).whenComplete(() {
    //   _value = true;
    // }).catchError((e) {
    //   _value = false;
    // });
    // print(_value);
    // print(response.data);
    // return _value;

    // Dio dio = new Dio();
    // Response response = await dio.get("https://178.128.211.167");
    // print(response.data.toString());
  }
}