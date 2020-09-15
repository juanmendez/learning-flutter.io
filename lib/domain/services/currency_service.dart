import 'package:http/http.dart' as http;
import 'package:learning_flutter/constants/Strings.dart';
import 'package:learning_flutter/models/currency_exchange.dart';

class CurrencyService {
  static final _CURRENCIES = <String, CurrencyExchange>{};

  static Future<List<CurrencyExchange>> getCurrencies() async {
    final url = Strings.getConversionUrl();
    final json = await http.get(url);

    return CurrencyExchange.fromRawList(json.body);
  }

  static Future<CurrencyExchange> convert(String selectedCurrency) async {
    if(_CURRENCIES.isEmpty) {
      final currencies = await getCurrencies();

      currencies.forEach((element) {
        _CURRENCIES[element.currency] = element;
      });
    }

    return _CURRENCIES[selectedCurrency];
  }
}