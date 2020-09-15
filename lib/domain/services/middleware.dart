import 'dart:developer' as d;

import 'package:learning_flutter/models/app_state.dart';
import 'package:redux/redux.dart';

Middleware<AppState> logEvents() {
  return (Store<AppState> store, dynamic action, NextDispatcher next,) {
    d.log(action.toString());
    next(action);
  };
}
