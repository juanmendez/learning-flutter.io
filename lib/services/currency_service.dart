import 'package:http/http.dart' as http;
import 'package:learning_flutter/constants/Strings.dart';
import 'package:learning_flutter/models/currency_exchange.dart';

class CurrencyService {
  static final _CURRENCIES = <String, CurrencyExchange>{};

  static Future<CurrencyExchange> convert(String selectedCurrency) async {
    if(_CURRENCIES.isEmpty) {
      final url = Strings.getConversionUrl();
      final json = await http.get(url);

      CurrencyExchange.fromRawList(json.body).forEach((element) {
        _CURRENCIES[element.currency] = element;
      });
    }

    return _CURRENCIES[selectedCurrency];
  }
}