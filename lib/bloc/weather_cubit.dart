import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_flutter/model/weather_models.dart';
import 'package:learning_flutter/services/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  void weatherByCity(String city) async {
    emit(WeatherLoading());

    try {
      if (city.isEmpty) {
        emit(WeatherError('City is not available'));
      } else {
        final result = await WeatherModel.getWeatherByCity(city);
        emit(WeatherSuccess(result));
      }
    } on Exception catch (err) {
      emit(WeatherError(err.toString() + '\nPress on the circle to try again.'));
    }
  }

  void weatherByLocation() async {
    emit(WeatherLoading());

    try {
      final result = await WeatherModel.getWeatherByLocation();
      emit(WeatherSuccess(result));
    } on Exception catch (err) {
      emit(WeatherError(err.toString() + '\nPress on the circle to try again.'));
    }
  }
}
