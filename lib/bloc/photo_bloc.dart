import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_flutter/model/photo_models.dart';
import 'package:learning_flutter/services/network_result.dart';
import 'package:learning_flutter/services/weather.dart';

part 'photo_event.dart';

part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoInitial());

  @override
  Stream<PhotoState> mapEventToState(
    PhotoEvent event,
  ) async* {
    yield PhotoInitial();

    try {
      NetworkResult<PhotoResult> photoResult = await WeatherModel.getPhoto(event.city);
      final data = photoResult.data;

      if (data?.photos.isNotEmpty == true) {
        yield PhotoSuccess(data!.photos.first.src.large);
      } else {
        throw 'there are no images coming from API service';
      }
    } catch (error) {
      yield PhotoError(error.toString());
    }
  }
}
