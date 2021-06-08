part of 'weather_bloc.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class WeatherByGeolocationEvent extends WeatherEvent {}

class WeatherByCityEvent extends WeatherEvent {
  const WeatherByCityEvent(this.city);

  final String city;
}
