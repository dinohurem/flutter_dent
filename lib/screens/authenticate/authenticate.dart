// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_provider/screens/authenticate/register.dart';
import 'package:flutter_provider/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignIn(
            toggleView: toggleView,
          )
        : Register(
            toggleView: toggleView,
          );
  }
}
