import 'package:flutter/material.dart';
import 'package:flutter_provider/screens/drawer/drawer_widget.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'SH Dent - Settings',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5), child: Container()),
      drawer: DrawerWidget(),
    );
  }
}
