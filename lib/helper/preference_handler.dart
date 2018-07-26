import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class PreferenceHandler {
  //Retrives data from a defined key in Shared Prefence storage.
  static Future<String> exist(key) async {
    String value = "";

    await SharedPreferences.getInstance().then((response) {
      if (response.get(key) != null) {
        value = response.get(key);
      }
    }).catchError((e) {
      print(e.toString());
    });

    return value;
  }
}
