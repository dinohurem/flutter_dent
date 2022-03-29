import 'package:flutter/material.dart';

class DrawerStateInfo with ChangeNotifier {
  String _currentDrawer = 'calendar';
  String get getCurrentDrawer => _currentDrawer;

  void setCurrentDrawer(String drawer) {
    _currentDrawer = drawer;
    notifyListeners();
  }
}
