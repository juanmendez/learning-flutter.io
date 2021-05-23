import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:learning_flutter/model/photo_models.dart';
import 'package:learning_flutter/model/weather_models.dart';
import 'package:learning_flutter/utilities/Strings.dart';

import 'location.dart';
import 'network_result.dart';

class WeatherModel {
  static Future<NetworkResult<WeatherResult>> getWeatherByLocation() async {
    final Position position = await Location.getLocation();
    final result = await WeatherModel.getWeatherResult(position);

    return result;
  }

  // https://www.pexels.com/api/documentation/#photos-search
  static Future<NetworkResult<PhotoResult>> getPhoto(
      String city) async {
    final request = Uri.parse(Strings.getPhotoByCity(city));
    final response = await http.get(request, headers: Strings.getPhotoHeader());

    NetworkResult<PhotoResult> result;

    if (response.statusCode == 200) {
      final photoResult = PhotoResult.fromRawJson(response.body);
      result = NetworkResult(data: photoResult);
    } else {
      result = NetworkResult(exception: HttpException("network error"));
    }

    return result;
  }

  static Future<NetworkResult<WeatherResult>> getWeatherByCity(
      String city) async {
    final request = Uri.parse(Strings.getWeatherCityUrl(city));
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

  static Future<NetworkResult<WeatherResult>> getWeatherResult(Position position) async {
    final String url = Strings.getWeatherLocationUrl(
      position.latitude,
      position.longitude,
    );

    final response = await http.get(Uri.parse(url));
    NetworkResult<WeatherResult> result;

    if (response.statusCode == 200) {
      final weatherResult = WeatherResult.fromRawJson(response.body);
      result = NetworkResult(data: weatherResult);
    } else {
      result = NetworkResult(exception: HttpException("network error"));
    }

    return result;
  }

  static String getWeatherIcon(int condition) {
    // Kotlin is far more modern than Dart
    if (condition == 0) {
      return '🤷‍';
    } else if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  static String getMessage(int temp) {
    if (temp > 80) {
      return 'It\'s 🍦 time';
    } else if (temp > 60) {
      return 'Time for shorts and 👕';
    } else if (temp < 30) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
