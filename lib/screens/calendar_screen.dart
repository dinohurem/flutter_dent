library event_calendar;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_provider/extensions/time_of_day_extension.dart';
import 'package:flutter_provider/models/data_source.dart';
import 'package:flutter_provider/models/meeting.dart';
import 'package:flutter_provider/screens/drawer_widget.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'appointment_builder.dart';
import 'appointment_divider.dart';
part 'appointment_editor.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

Color _currentColor = Colors.white;
List<Color> _colorCollection = <Color>[];
List<String> _timeZoneCollection = <String>[];
late DataSource _events;
Meeting? _selectedAppointment;
late DateTime _startDate;
late TimeOfDay _startTime;
late DateTime _endDate;
late TimeOfDay _endTime;
String _subject = '';
String _notes = '';

class CalendarScreenState extends State<CalendarScreen> {
  CalendarScreenState();

  CalendarView _calendarView = CalendarView.workWeek;
  late List<String> eventNameCollection;
  late List<Meeting> appointments;

  @override
  void initState() {
    _calendarView = CalendarView.workWeek;
    appointments = getMeetingDetails();
    _events = DataSource(appointments);
    _selectedAppointment = null;
    _subject = '';
    _notes = '';
    super.initState();
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    setState(
      () {
        _selectedAppointment = null;
        _subject = '';
        _notes = '';
        if (_calendarView == CalendarView.month) {
          _calendarView = CalendarView.day;
        } else {
          if (calendarTapDetails.appointments != null &&
              calendarTapDetails.appointments!.length == 1) {
            final Meeting meetingDetails = calendarTapDetails.appointments![0];
            _startDate = meetingDetails.from;
            _endDate = meetingDetails.to;
            _subject = meetingDetails.eventName == '(No title)'
                ? ''
                : meetingDetails.eventName;
            _notes = meetingDetails.description;
            _selectedAppointment = meetingDetails;
            _currentColor = meetingDetails.background;
          } else {
            final DateTime date = calendarTapDetails.date!;
            _startDate = date;
            _endDate = date.add(const Duration(hours: 1));
          }
          _startTime =
              TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
          _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);

          Navigator.push<Widget>(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const AppointmentEditor(),
            ),
          );
        }
      },
    );
  }

  SfCalendar getCalendarScreen(
      CalendarView _calendarView,
      CalendarDataSource _calendarDataSource,
      CalendarTapCallback calendarTapCallback) {
    return SfCalendar(
      showNavigationArrow: true,
      showDatePickerButton: true,
      headerDateFormat: 'MMMM yyyy',
      view: _calendarView,
      // ignore: prefer_const_literals_to_create_immutables
      allowedViews: [
        CalendarView.day,
        CalendarView.week,
        CalendarView.workWeek,
        CalendarView.month
      ],
      showCurrentTimeIndicator: true,
      firstDayOfWeek: 1,
      dataSource: _calendarDataSource,
      appointmentBuilder:
          _calendarView != CalendarView.month ? appointmentBuilder : null,
      onTap: calendarTapCallback,
      // onViewChanged: calendarViewCallback,
      initialDisplayDate: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0),
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        navigationDirection: MonthNavigationDirection.vertical,
      ),
      timeSlotViewSettings: const TimeSlotViewSettings(
        minimumAppointmentDuration: Duration(minutes: 60),
      ),
    );
  }

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
            description: '',
            eventName: eventNameCollection[random.nextInt(7)],
          ));
        }
      }
    }

    return meetingCollection;
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Meeting meeting = calendarAppointmentDetails.appointments.first;
    return AppointmentBuilder(
      meeting: meeting,
      calendarAppointmentDetails: calendarAppointmentDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'SH Dent - Kalendar',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
        child: getCalendarScreen(
          _calendarView,
          _events,
          onCalendarTapped,
        ),
      ),
      // ignore: prefer_const_constructors
      drawer: DrawerWidget(),
    );
  }
}
