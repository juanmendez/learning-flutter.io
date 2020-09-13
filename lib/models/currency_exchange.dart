// To parse this JSON data, do
//
//     final currencyConversion = currencyConversionFromJson(jsonString);

import 'dart:convert';

class CurrencyExchange {
  CurrencyExchange({
    this.currency,
    this.rate,
    this.timestamp,
  });

  final String currency;
  final String rate;
  final DateTime timestamp;

  factory CurrencyExchange.fromRawJson(String str) => CurrencyExchange.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  static List<CurrencyExchange> fromRawList(String str) {
    final List<dynamic> jsonItems = json.decode(str);

    return jsonItems.map((e) => CurrencyExchange.fromJson(e)).toList();
  }

  factory CurrencyExchange.fromJson(Map<String, dynamic> json) => CurrencyExchange(
    currency: json["currency"],
    rate: json["rate"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "rate": rate,
    "timestamp": timestamp.toIso8601String(),
  };
}