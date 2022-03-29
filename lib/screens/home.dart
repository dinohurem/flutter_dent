// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_provider/models/drawer_state_info.dart';
import 'package:flutter_provider/screens/calendar/calendar_screen.dart';
import 'package:flutter_provider/screens/doctors/doctors.dart';
import 'package:flutter_provider/screens/patients/patients.dart';
import 'package:flutter_provider/screens/settings/settings.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _setScreen(String screen) {
    switch (screen) {
      case 'settings':
        return Settings();
      case 'patients':
        return Patients();
      case 'doctors':
        return Doctors();
      default:
        return CalendarScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentDrawer = Provider.of<DrawerStateInfo>(context).getCurrentDrawer;

    return _setScreen(currentDrawer);
  }
}
