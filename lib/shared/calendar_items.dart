import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_provider/models/meeting.dart';

List<Color> _colorCollection = <Color>[];
List<String> _timeZoneCollection = <String>[];
late List<String> eventNameCollection;
List<String> descriptionCollection = <String>[];

List<Meeting> getMeetingDetails() {
  final List<Meeting> meetingCollection = <Meeting>[];
  eventNameCollection = <String>[];
  eventNameCollection.add('General Meeting');
  eventNameCollection.add('Plan Execution');
  eventNameCollection.add('Project Plan');
  eventNameCollection.add('Consulting');
  eventNameCollection.add('Support');
  eventNameCollection.add('Development Meeting');
  eventNameCollection.add('Scrum');
  eventNameCollection.add('Project Completion');
  eventNameCollection.add('Release updates');
  eventNameCollection.add('Performance Check');

  descriptionCollection.add('rasgrsg Meeting');
  descriptionCollection.add('srg Execution');
  descriptionCollection.add('ar Plan');
  descriptionCollection.add('aa');
  descriptionCollection.add('aa');
  descriptionCollection.add('aeaer Meeting');
  descriptionCollection.add('try');
  descriptionCollection.add('rth Completion');
  descriptionCollection.add('r updates');
  descriptionCollection.add('rthhhrth Check');

  _colorCollection = <Color>[];
  _colorCollection.add(const Color(0xFF0F8644));
  _colorCollection.add(const Color(0xFF8B1FA9));
  _colorCollection.add(const Color(0xFFD20100));
  _colorCollection.add(const Color(0xFFFC571D));
  _colorCollection.add(const Color(0xFF85461E));
  _colorCollection.add(const Color(0xFFFF00FF));
  _colorCollection.add(const Color(0xFF3D4FB5));
  _colorCollection.add(const Color(0xFFE47C73));
  _colorCollection.add(const Color(0xFF636363));

  _timeZoneCollection = <String>[];
  _timeZoneCollection.add('Central European Standard Time');

  final DateTime today = DateTime.now();
  final Random random = Random();
  for (int month = -1; month < 2; month++) {
    for (int day = -5; day < 5; day++) {
      for (int hour = 9; hour < 18; hour += 5) {
        meetingCollection.add(Meeting(
          from: today
              .add(Duration(days: (month * 30) + day))
              .add(Duration(hours: hour)),
          to: today
              .add(Duration(days: (month * 30) + day))
              .add(Duration(hours: hour + 1)),
          background: _colorCollection[random.nextInt(9)],
          description: descriptionCollection[random.nextInt(7)],
          eventName: eventNameCollection[random.nextInt(7)],
        ));
      }
    }
  }

  return meetingCollection;
}
