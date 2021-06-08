part of 'weather_bloc.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState with EquatableMixin {
  const WeatherLoading();

  @override
  List<Object> get props => [];
}

class WeatherSuccess extends WeatherState with EquatableMixin {
  final WeatherResult result;

  const WeatherSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class WeatherError extends WeatherState with EquatableMixin {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
