import 'package:learning_flutter/domain/services/currency_service.dart';
import 'package:learning_flutter/domain/vo/resource.dart';
import 'package:learning_flutter/domain/vo/status.dart';
import 'package:learning_flutter/models/app_state.dart';
import 'package:learning_flutter/models/currency_exchange.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

AppState getCurrencyCollection(
    AppState state, Resource<Map<String, CurrencyExchange>> action) {
  if (action.status == Status.LOADING) {
    return state.copyWith(isLoading: true);
  } else if (action.status == Status.SUCCESS) {
    return state.copyWith(isLoading: false, currencies: action.data);
  } else {
    return state.copyWith(isLoading: false);
  }
}

ThunkAction<AppState> fetchCurrencies = (Store<AppState> store) async {
  store.dispatch(Resource<Map<String, CurrencyExchange>>.loading());

  final currencies = await CurrencyService.getCurrencies();
  final map = <String, CurrencyExchange>{};
  currencies.forEach((element) {
    map[element.currency] = element;
  });

  store.dispatch(Resource.success(map));
};
