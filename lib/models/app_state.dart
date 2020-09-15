import 'package:flutter/cupertino.dart';
import 'package:learning_flutter/models/currency_exchange.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool isLoading;
  Map<String, CurrencyExchange> currencies;
  CurrencyExchange currencyExchange;

  AppState(
      {this.isLoading = false,
      this.currencies = const {},
      this.currencyExchange});

  AppState copyWith({
    bool isLoading,
    Map<String, CurrencyExchange> currencies,
    CurrencyExchange currencyExchange,
  }) {
    return AppState(
        isLoading: isLoading ?? this.isLoading,
        currencies: currencies ?? this.currencies,
        currencyExchange: currencyExchange);
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^ currencies.hashCode ^ currencyExchange?.hashCode;

  @override
  bool operator(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            isLoading == other.isLoading &&
            currencies == other.currencies &&
            currencyExchange == other.currencyExchange;
  }

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, currencies: $currencies, exchange: $currencyExchange';
  }
}
