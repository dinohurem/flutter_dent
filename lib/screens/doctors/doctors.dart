import 'package:flutter/material.dart';
import 'package:flutter_provider/screens/drawer/drawer_widget.dart';

class Doctors extends StatefulWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'SH Dent - Doctors',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5), child: Container()),
      drawer: DrawerWidget(),
    );
  }
}
