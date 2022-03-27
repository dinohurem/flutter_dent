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
        Flexible(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0, color: meeting.background),
              color: meeting.background,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: calendarAppointmentDetails.bounds.width / 40,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 6,
                    child: Text(
                      meeting.eventName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Text(
                      DateFormat('HH:mm').format(meeting.from) +
                          ' - ' +
                          DateFormat('HH:mm').format(meeting.to),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize:
                            calendarAppointmentDetails.bounds.height / 2.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0, color: meeting.background),
              color: meeting.background,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: calendarAppointmentDetails.bounds.width / 40),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: Text(
                      meeting.description,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
