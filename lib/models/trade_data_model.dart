import 'package:flutter/foundation.dart';

class PriceProvider extends ChangeNotifier {
  double _price = 0.0;

  double get price => _price;

  set price(double value) {
    _price = value;
    notifyListeners();
  }
}
