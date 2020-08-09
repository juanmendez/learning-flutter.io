import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:learning_flutter/model/models.dart';
import 'package:learning_flutter/services/network_result.dart';
import 'package:learning_flutter/utilities/Strings.dart';

class NetworkHelper {
  static Future<NetworkResult<WeatherResult>> getWeatherResult(
      Position position) async {
    final String request = Strings.getLocation(
      position.latitude,
      position.longitude,
    );

    final response = await http.get(request);
    NetworkResult<WeatherResult> result;

    if (response.statusCode == 200) {
      final weatherResult = WeatherResult.fromRawJson(response.body);
      result = NetworkResult(data: weatherResult);
    } else {
      result = NetworkResult(exception: HttpException("network error"));
    }

    return result;
  }
}
