import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_flutter/model/weather_models.dart';
import 'package:learning_flutter/services/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    yield WeatherLoading();

    try {
      if (event is WeatherInitial) {
        add(WeatherByGeolocationEvent());
      } else if (event is WeatherByCityEvent) {
        if (event.city.isEmpty) {
          yield WeatherError('City is not available');
        } else {
          final result = await WeatherModel.getWeatherByCity(event.city);
          yield WeatherSuccess(result);
        }
      } else if (event is WeatherByGeolocationEvent) {
        final result = await WeatherModel.getWeatherByLocation();
        yield WeatherSuccess(result);
      }
    } on Exception catch (err) {
      yield WeatherError(err.toString() + '\nPress on the circle to try again.');
    }
  }
}
