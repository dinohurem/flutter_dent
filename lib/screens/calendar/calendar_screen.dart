library event_calendar;

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_provider/data/calendar_items.dart';
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

  final CalendarController _controller = CalendarController();
  late CalendarView _calendarView;
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

  void _viewChangedCallback(ViewChangedDetails details) {
    if (_controller.view == _calendarView) {
      return;
    }
    _calendarView = _controller.view!;
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
        if (_calendarView == CalendarView.month &&
            calendarTapDetails.targetElement == CalendarElement.calendarCell) {
          _calendarView = CalendarView.day;
          _controller.view = _calendarView;
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
      controller: _controller,
      showNavigationArrow: true,
      showDatePickerButton: true,
      headerDateFormat: 'MMMM yyyy',
      view: _calendarView,
      allowedViews: const [
        CalendarView.day,
        CalendarView.week,
        CalendarView.workWeek,
        CalendarView.month
      ],
      showCurrentTimeIndicator: true,
      firstDayOfWeek: 1,
      dataSource: _calendarDataSource,
      appointmentBuilder: appointmentBuilder,
      onTap: calendarTapCallback,
      onViewChanged: _viewChangedCallback,
      initialDisplayDate: DateTime.now(),
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        navigationDirection: MonthNavigationDirection.vertical,
        appointmentDisplayCount: 4,
      ),
      timeSlotViewSettings: const TimeSlotViewSettings(
        dayFormat: 'EEE',
        timeFormat: 'HH:mm',
        minimumAppointmentDuration: Duration(minutes: 30),
      ),
    );
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Meeting meeting = calendarAppointmentDetails.appointments.first;
    return AppointmentBuilder(
      calendarView: _calendarView,
      meeting: meeting,
      calendarAppointmentDetails: calendarAppointmentDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'SH Dent - Kalendar - #stolice',
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
