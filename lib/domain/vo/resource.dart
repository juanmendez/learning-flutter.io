import 'package:flutter/material.dart';
import 'package:learning_flutter/domain/vo/status.dart';

class Resource<T> {
  final Status status;
  T data;
  String message;
  Exception exception;

  Resource({
    @required this.status,
    this.data,
    this.message,
    this.exception,
  });

  factory Resource.success(T data) {
    return Resource(status: Status.SUCCESS, data: data);
  }

  factory Resource.error({String message, Exception exception}) {
    return Resource(
      status: Status.ERROR,
      message: message,
      exception: exception,
    );
  }

  factory Resource.loading({T data}) {
    return Resource(status: Status.LOADING, data: data);
  }

  @override
  String toString() {
    return '${status.toString()}';
  }
}
