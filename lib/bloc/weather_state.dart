part of 'weather_bloc.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();

  @override
  List<Object> get props => [];
}

class WeatherSuccess extends WeatherState {
  final WeatherResult result;

  const WeatherSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
