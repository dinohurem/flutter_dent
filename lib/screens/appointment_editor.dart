part of event_calendar;

class AppointmentEditor extends StatefulWidget {
  const AppointmentEditor({Key? key}) : super(key: key);

  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  int _appointmentDuration = 0;

  @override
  void initState() {
    _currentColor = _currentColor;
    _appointmentDuration = _endDate.difference(_startDate).inMinutes;
    super.initState();
  }

  void changeColor(Color color) => setState(() => _currentColor = color);

  Widget _getAppointmentEditor(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 25, 5),
              child: TextField(
                controller: TextEditingController(text: _subject),
                onChanged: (String value) {
                  _subject = value;
                },
                enabled: true,
                keyboardType: TextInputType.text,
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
                            _startDate = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                _startTime.hour,
                                _startTime.minute,
                                0);

                            _endDate = DateTime(
                                _endDate.year,
                                _endDate.month,
                                _endDate.day,
                                _endTime.hour,
                                _endTime.minute,
                                0);

                            _endTime = TimeOfDay(
                                hour: _endDate.hour, minute: _endDate.minute);
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),

            // Time picker.
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: const Icon(
                Icons.watch_later,
              ),
              title: GestureDetector(
                child: Text(
                  DateFormat('hh:mm a').format(_startDate),
                ),
                onTap: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                        hour: _startTime.hour, minute: _startTime.minute),
                    builder: (context, childWidget) {
                      return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: childWidget!);
                    },
                  );

                  if (time != null && time != _startTime) {
                    setState(
                      () {
                        _startTime = time;

                        _startDate = DateTime(
                            _startDate.year,
                            _startDate.month,
                            _startDate.day,
                            _startTime.hour,
                            _startTime.minute,
                            0);

                        _endTime = _startTime.plusMinutes(_appointmentDuration);
                        _endDate = DateTime(_endDate.year, _endDate.month,
                            _endDate.day, _endTime.hour, _endTime.minute, 0);
                      },
                    );
                  }
                },
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: const Icon(
                Icons.timer,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NumberPicker(
                    value: _appointmentDuration,
                    minValue: 0,
                    maxValue: 120,
                    itemHeight: 35,
                    itemCount: 4,
                    infiniteLoop: true,
                    onChanged: (value) =>
                        setState(() => _appointmentDuration = value),
                    haptics: true,
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
              leading: Icon(Icons.rectangle, color: _currentColor),
              title: Text(
                _currentColor.toString().contains('Material')
                    ? 'Please choose a color'
                    : '#${_currentColor.value.toRadixString(16).substring(2, 8)}',
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
              onTap: () {
                showDialog<Widget>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: Colors.red,
                          onColorChanged: changeColor,
                          enableLabel: true,
                          portraitOnly: false,
                        ),
                      ),
                    );
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
              backgroundColor: _currentColor,
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
                        background: _currentColor,
                        description: _notes,
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
