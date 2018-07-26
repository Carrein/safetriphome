import 'package:geolocation/geolocation.dart';
import 'dart:async';

class LocationHandler {
  static Future<LocationResult> getLocation() async {
    LocationResult value;
    final GeolocationResult result = await Geolocation.isLocationOperational();
    if (result.isSuccessful) {
      Geolocation
          .singleLocationUpdate(accuracy: LocationAccuracy.best)
          .listen((response) {
        if (response.isSuccessful) {
          value = response;
        }else{
          value = null;
        }
      });
    }
    return value;
  }
}
