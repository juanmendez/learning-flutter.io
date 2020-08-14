import 'package:flutter/foundation.dart';

enum Flavor { increment, decrement }

class FlavorHolder extends ChangeNotifier {
  Flavor _flavor = Flavor.increment;

  Flavor get flavor => _flavor;

  void change() {
    if (_flavor == Flavor.increment) {
      _flavor = Flavor.decrement;
    } else {
      _flavor = Flavor.increment;
    }

    notifyListeners();
  }
}
