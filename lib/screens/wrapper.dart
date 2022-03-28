import 'package:flutter/material.dart';
import 'package:flutter_provider/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Return either home or authenticate widget.
    return const Authenticate();
  }
}