import 'package:learning_flutter/domain/reducers/currency_collection/currency_collection_reducer.dart';
import 'package:learning_flutter/domain/vo/resource.dart';
import 'package:learning_flutter/models/app_state.dart';
import 'package:learning_flutter/models/currency_exchange.dart';
import 'package:redux/redux.dart';

import 'currency/currency_reducer.dart';

final appReducer = combineReducers<AppState>([
    TypedReducer<AppState, Resource<Map<String,CurrencyExchange>>>(
        getCurrencyCollection
    ),
    TypedReducer<AppState, Resource<CurrencyExchange>>(
        getCurrencyExchange
    )
]);