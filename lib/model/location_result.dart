import 'package:learning_flutter/model/weather_models.dart';

// Freezed can be useful in here, so we make new copies each time
class LocationResult {
  LocationResult({
    this.weatherResult,
    this.locationBackground,
  });

  WeatherResult? weatherResult;
  String? locationBackground;

  LocationResult copy() {
    return LocationResult(
      weatherResult: weatherResult,
      locationBackground: locationBackground,
    );
  }
}
