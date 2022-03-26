import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/meeting.dart';

class AppointmentBuilder extends StatelessWidget {
  const AppointmentBuilder({
    Key? key,
    required this.meeting,
    required this.calendarAppointmentDetails,
  }) : super(key: key);

  final Meeting meeting;
  final CalendarAppointmentDetails calendarAppointmentDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: meeting.background,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: calendarAppointmentDetails.bounds.width / 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  meeting.eventName.length > 10
                      ? meeting.eventName.substring(0, 10) + '...'
                      : meeting.eventName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: calendarAppointmentDetails.bounds.height / 2.5,
                  ),
                ),
                Text(
                  DateFormat('HH:mm').format(meeting.from) +
                      ' - ' +
                      DateFormat('HH:mm').format(meeting.to),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: calendarAppointmentDetails.bounds.height / 2.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.zero,
            color: meeting.background,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  left: calendarAppointmentDetails.bounds.width / 40),
              child: Text(
                meeting.description,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: calendarAppointmentDetails.bounds.height / 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
