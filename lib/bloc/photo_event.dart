part of 'photo_bloc.dart';

class PhotoEvent extends Equatable {
  PhotoEvent(this.city);
  final String city;

  @override
  List<Object> get props => [city];
}
