import 'package:flutter/material.dart';
import 'package:flutter_provider/models/meeting.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentBuilder extends StatelessWidget {
  final Meeting meeting;
  final CalendarAppointmentDetails calendarAppointmentDetails;
  final CalendarView calendarView;

  const AppointmentBuilder({
    Key? key,
    required this.calendarView,
    required this.meeting,
    required this.calendarAppointmentDetails,
  }) : super(key: key);

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
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: calendarView == CalendarView.month
                            ? calendarAppointmentDetails.bounds.height / 2.5
                            : calendarAppointmentDetails.bounds.height / 3,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: calendarView == CalendarView.month
                        ? Container()
                        : Text(
                            DateFormat('HH:mm').format(meeting.from) +
                                ' - ' +
                                DateFormat('HH:mm').format(meeting.to),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  calendarAppointmentDetails.bounds.height / 3,
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
                    child: calendarView == CalendarView.month
                        ? Container()
                        : Text(
                            meeting.description,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: calendarView == CalendarView.month
                                    ? calendarAppointmentDetails.bounds.height /
                                        5
                                    : calendarAppointmentDetails.bounds.height /
                                        3),
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
