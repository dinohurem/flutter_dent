import 'package:flutter/material.dart';
import 'package:flutter_provider/screens/calendar/calendar_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: const CalendarScreen(),
    );
  }
}
