import 'package:flutter/material.dart';
import 'package:flutter_provider/models/user.dart';
import 'package:flutter_provider/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<Doctor?>(context);
    print(doctor);
    // Return either home or authenticate widget.
    return const Authenticate();
  }
}
