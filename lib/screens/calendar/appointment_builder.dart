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
    return Container(
      height: calendarAppointmentDetails.bounds.height,
      width: calendarAppointmentDetails.bounds.width,
      color: meeting.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: calendarView != CalendarView.day
                  ? calendarAppointmentDetails.bounds.width * 0.05
                  : calendarAppointmentDetails.bounds.width * 0.005,
            ),
            child: SizedBox(
              width: calendarView == CalendarView.month
                  ? calendarAppointmentDetails.bounds.width
                  : calendarAppointmentDetails.bounds.width * 0.9,
              height: calendarView == CalendarView.month
                  ? calendarAppointmentDetails.bounds.height
                  : calendarAppointmentDetails.bounds.height / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: calendarAppointmentDetails.bounds.width * 0.5,
                    child: Text(
                      meeting.eventName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: calendarView == CalendarView.month
                            ? calendarAppointmentDetails.bounds.height * 0.425
                            : calendarAppointmentDetails.bounds.height * 0.375,
                      ),
                    ),
                  ),
                  Container(
                    width: calendarAppointmentDetails.bounds.width * 0.05,
                  ),
                  SizedBox(
                    width: calendarAppointmentDetails.bounds.width * 0.35,
                    child: Text(
                      DateFormat('HH:mm').format(meeting.from) +
                          ' - ' +
                          DateFormat('HH:mm').format(meeting.to),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: calendarView == CalendarView.month
                            ? calendarAppointmentDetails.bounds.height * 0.4
                            : calendarAppointmentDetails.bounds.height * 0.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (calendarView != CalendarView.month)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: calendarView != CalendarView.day
                    ? calendarAppointmentDetails.bounds.width * 0.05
                    : calendarAppointmentDetails.bounds.width * 0.005,
              ),
              child: SizedBox(
                height: calendarAppointmentDetails.bounds.height / 2,
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
        ],
      ),
    );
  }
}
