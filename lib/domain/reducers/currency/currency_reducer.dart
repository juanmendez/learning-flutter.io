import 'dart:developer' as d;

import 'package:learning_flutter/domain/services/currency_service.dart';
import 'package:learning_flutter/domain/vo/resource.dart';
import 'package:learning_flutter/domain/vo/status.dart';
import 'package:learning_flutter/models/app_state.dart';
import 'package:learning_flutter/models/currency_exchange.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

AppState getCurrencyExchange(
    AppState state, Resource<CurrencyExchange> action) {
  if (action.status == Status.LOADING) {
    return state.copyWith(isLoading: true);
  } else if (action.status == Status.SUCCESS) {
    return state.copyWith(isLoading: false, currencyExchange: action.data);
  } else {
    return state.copyWith(isLoading: false);
  }
}

ThunkAction<AppState> getCurrency(String currency) {
  d.log("requested to load $currency");

  return (Store<AppState> store) async {
    if(store.state.currencyExchange?.currency != currency) {
      store.dispatch(Resource<CurrencyExchange>.loading());
      final currencyExchange = await CurrencyService.convert(currency);
      store.dispatch(Resource.success(currencyExchange));
    }
  };
}
