import 'package:flutter/material.dart';
import 'package:flutter_provider/screens/drawer/drawer_widget.dart';

class Patients extends StatefulWidget {
  const Patients({Key? key}) : super(key: key);

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'SH Dent - Patients',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5), child: Container()),
      drawer: DrawerWidget(),
    );
  }
}
