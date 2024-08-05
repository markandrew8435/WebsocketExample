import 'package:flutter/foundation.dart';

class TradeDataModel extends ChangeNotifier {
  double _price = 0.0;

  double get price => _price;

  void updatePrice(double newPrice) {
    _price = newPrice;
    notifyListeners();
  }
}
