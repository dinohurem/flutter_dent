part of event_calendar;

class AppointmentEditor extends StatefulWidget {
  const AppointmentEditor({Key? key}) : super(key: key);

  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  Widget _getAppointmentEditor(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 0, 25, 5),
              leading: const Text(''),
              title: TextField(
                controller: TextEditingController(text: _subject),
                onChanged: (String value) {
                  _subject = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add title',
                ),
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: const Icon(
                Icons.calendar_today,
                color: Colors.grey,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                      child: Text(
                          DateFormat('EEE, MMM dd yyyy').format(_startDate),
                          textAlign: TextAlign.left),
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );

                        if (date != null && date != _startDate) {
                          setState(() {
                            final Duration difference =
                                _endDate.difference(_startDate);
                            _startDate = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                _startTime.hour,
                                _startTime.minute,
                                0);
                            _endDate = _startDate.add(difference);
                            _endTime = TimeOfDay(
                                hour: _endDate.hour, minute: _endDate.minute);
                          });
                        }
                      },
                    ),
                  ),

                  // Time picker.
                  Expanded(
                    flex: 3,
                    child: _isAllDay
                        ? const Text('')
                        : GestureDetector(
                            child: Text(
                              DateFormat('hh:mm a').format(_startDate),
                              textAlign: TextAlign.right,
                            ),
                            onTap: () async {
                              final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: _startTime.hour,
                                    minute: _startTime.minute),
                                builder: (context, childWidget) {
                                  return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          // Using 24-Hour format
                                          alwaysUse24HourFormat: true),
                                      // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                      child: childWidget!);
                                },
                              );

                              if (time != null && time != _startTime) {
                                setState(
                                  () {
                                    _startTime = time;
                                    final Duration difference =
                                        _endDate.difference(_startDate);
                                    _startDate = DateTime(
                                        _startDate.year,
                                        _startDate.month,
                                        _startDate.day,
                                        _startTime.hour,
                                        _startTime.minute,
                                        0);
                                    _endDate = _startDate.add(difference);
                                    _endTime = TimeOfDay(
                                        hour: _endDate.hour,
                                        minute: _endDate.minute);
                                  },
                                );
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),

            // 2nd date picker.
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: const Icon(
                Icons.calendar_today,
                color: Colors.grey,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                      child: Text(
                        DateFormat('EEE, MMM dd yyyy').format(_endDate),
                        textAlign: TextAlign.left,
                      ),
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: _endDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );

                        if (date != null && date != _endDate) {
                          setState(
                            () {
                              final Duration difference =
                                  _endDate.difference(_startDate);
                              _endDate = DateTime(date.year, date.month,
                                  date.day, _endTime.hour, _endTime.minute, 0);
                              if (_endDate.isBefore(_startDate)) {
                                _startDate = _endDate.subtract(difference);
                                _startTime = TimeOfDay(
                                    hour: _startDate.hour,
                                    minute: _startDate.minute);
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _isAllDay
                        ? const Text('')
                        : GestureDetector(
                            child: Text(
                              DateFormat('hh:mm a').format(_endDate),
                              textAlign: TextAlign.right,
                            ),
                            onTap: () async {
                              final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: _endTime.hour,
                                    minute: _endTime.minute),
                                builder: (context, childWidget) {
                                  return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          // Using 24-Hour format
                                          alwaysUse24HourFormat: true),
                                      // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                      child: childWidget!);
                                },
                              );

                              if (time != null && time != _endTime) {
                                setState(
                                  () {
                                    _endTime = time;
                                    final Duration difference =
                                        _endDate.difference(_startDate);
                                    _endDate = DateTime(
                                        _endDate.year,
                                        _endDate.month,
                                        _endDate.day,
                                        _endTime.hour,
                                        _endTime.minute,
                                        0);
                                    if (_endDate.isBefore(_startDate)) {
                                      _startDate =
                                          _endDate.subtract(difference);
                                      _startTime = TimeOfDay(
                                          hour: _startDate.hour,
                                          minute: _startDate.minute);
                                    }
                                  },
                                );
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: Icon(Icons.lens,
                  color: _colorCollection[_selectedColorIndex]),
              title: Text(
                _colorNames[_selectedColorIndex],
              ),
              onTap: () {
                showDialog<Widget>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return _ColorPicker();
                  },
                ).then((dynamic value) => setState(() {}));
              },
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(5),
              leading: const Icon(
                Icons.subject,
                color: Colors.black87,
              ),
              title: TextField(
                controller: TextEditingController(text: _notes),
                onChanged: (String value) {
                  _notes = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add description',
                ),
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                getTile(),
              ),
              backgroundColor: _colorCollection[_selectedColorIndex],
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                  padding: const EdgeInsets.fromLTRB(5, 0, 25, 0),
                  icon: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    final List<Meeting> meetings = <Meeting>[];
                    if (_selectedAppointment != null) {
                      _events.appointments!.removeAt(
                          _events.appointments!.indexOf(_selectedAppointment));

                      _events.notifyListeners(CalendarDataSourceAction.remove,
                          <Meeting>[_selectedAppointment!]);
                    }
                    meetings.add(
                      Meeting(
                        from: _startDate,
                        to: _endDate,
                        background: _colorCollection[_selectedColorIndex],
                        description: _notes,
                        isAllDay: _isAllDay,
                        eventName: _subject == '' ? '(No title)' : _subject,
                      ),
                    );

                    _events.appointments!.add(meetings[0]);

                    _events.notifyListeners(
                        CalendarDataSourceAction.add, meetings);
                    _selectedAppointment = null;

                    Navigator.pop(context);
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: Stack(
                children: <Widget>[_getAppointmentEditor(context)],
              ),
            ),
            floatingActionButton: _selectedAppointment == null
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      if (_selectedAppointment != null) {
                        _events.appointments!.removeAt(_events.appointments!
                            .indexOf(_selectedAppointment));
                        _events.notifyListeners(
                          CalendarDataSourceAction.remove,
                          <Meeting>[_selectedAppointment!],
                        );
                        _selectedAppointment = null;
                        Navigator.pop(context);
                      }
                    },
                    child:
                        const Icon(Icons.delete_outline, color: Colors.white),
                    backgroundColor: Colors.red,
                  )));
  }

  String getTile() {
    return _subject.isEmpty ? 'New appointment' : 'Appointment details';
  }
}
