import 'package:sprintf/sprintf.dart';

class Strings {
  static const API_KEY = "create your own openweathermap";
  static const GEO_LOCATOR = "https://api.openweathermap.org/data/2.5/weather?lat=%s&lon=%s&appid=%s";

  static String getLocation(double lat, double lon) {
    return sprintf(GEO_LOCATOR, [lat.toString(), lon.toString(), API_KEY]);
  }
}