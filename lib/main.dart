import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning_flutter/domain/reducers/currency_collection/currency_collection_reducer.dart';
import 'package:learning_flutter/models/app_state.dart';
import 'package:learning_flutter/models/currency_exchange.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'domain/reducers/app_reducer.dart';
import 'domain/reducers/currency/currency_reducer.dart';
import 'domain/services/middleware.dart';
import 'price_screen.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: [thunkMiddleware, logEvents()],
  );

  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.lightBlue,
            scaffoldBackgroundColor: Colors.white),
        home: StoreConnector<AppState, _ViewModel>(
          converter: (Store<AppState> store) => _ViewModel.create(store),
          builder: (BuildContext context, _ViewModel viewModel) {
            return PriceScreen(
              store.state.currencies.keys.toList(),
              store.state.currencyExchange ?? CurrencyExchange(),
              viewModel.onRequestCollection,
              viewModel.selectCurrency,
            );
          },
        ),
      ),
      store: store,
    );
  }
}

class _ViewModel {
  final Function() onRequestCollection;
  final Function(String) selectCurrency;

  _ViewModel({this.onRequestCollection, this.selectCurrency});

  factory _ViewModel.create(Store<AppState> store) {
    _onRequestCollection() {
      store.dispatch(fetchCurrencies);
    }

    _selectCurrency(String currency) {
      store.dispatch(getCurrency(currency));
    }

    return _ViewModel(
        onRequestCollection: _onRequestCollection,
        selectCurrency: _selectCurrency);
  }
}
