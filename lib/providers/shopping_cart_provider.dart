import 'package:flutter/material.dart';

class ShoppingCart with ChangeNotifier {
  // ignore: prefer_final_fields
  List<String> _shoppingCart = ['Apple', 'Orange', 'Pineapple'];

  int get count => _shoppingCart.length;

  List<String> get cart => _shoppingCart;

  void addItem(String item) {
    _shoppingCart.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    _shoppingCart.remove(item);
    notifyListeners();
  }

  void reset() {
    _shoppingCart.clear();
    notifyListeners();
  }
}
