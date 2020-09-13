import 'package:sprintf/sprintf.dart';

class Strings {

  static const NOMICS_API_KEY = 'get your api key from https://p.nomics.com/cryptocurrency-bitcoin-api';
  static const CONVERSION_CALL = 'https://api.nomics.com/v1/exchange-rates?key=%s';

  static String getConversionUrl() {
    return sprintf(CONVERSION_CALL, [NOMICS_API_KEY]);
  }
}