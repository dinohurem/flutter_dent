// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_provider/models/doctor.dart';
import 'package:flutter_provider/screens/authenticate/authenticate.dart';
import 'package:flutter_provider/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<Doctor?>(context);

    if (doctor == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
