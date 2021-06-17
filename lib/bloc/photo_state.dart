part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();
}

class PhotoInitial extends PhotoState {
  @override
  List<Object> get props => [];
}

class PhotoSuccess extends PhotoState with EquatableMixin {
  final String result;

  const PhotoSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class PhotoError extends PhotoState with EquatableMixin {
  final String message;

  const PhotoError(this.message);

  @override
  List<Object> get props => [message];
}