part of event_calendar;

class AppointmentEditor extends StatefulWidget {
  const AppointmentEditor({Key? key}) : super(key: key);

  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  int _appointmentDuration = 0;
  Color _chosenColor = Colors.white;

  @override
  void initState() {
    _appointmentDuration = _endDate.difference(_startDate).inMinutes;
    super.initState();
  }

  // Method for choosing color via alert dialog.
  void _chooseColor(Color color) => setState(() => _chosenColor = color);

  // Method for setting color of appointment when OK pressed in alert dialog.
  void _changeColor(Color color) => setState(() => _currentColor = color);

  String getTile() {
    return _subject.isEmpty ? 'New appointment' : 'Appointment details';
  }

  Widget _getAppointmentEditor(BuildContext context) {
    return ListView(
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
        const AppointmentDivider(),
        Material(
          type: MaterialType.transparency,
          child: ListTile(
            mouseCursor: SystemMouseCursors.click,
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: const Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
            title: Text(DateFormat('EEE, MMM dd yyyy').format(_startDate),
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
                  _startDate = DateTime(date.year, date.month, date.day,
                      _startTime.hour, _startTime.minute, 0);

                  _endDate = DateTime(_endDate.year, _endDate.month,
                      _endDate.day, _endTime.hour, _endTime.minute, 0);

                  _endTime =
                      TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
                });
              }
            },
          ),
        ),
        const AppointmentDivider(),
        // Time picker.
        ListTile(
          mouseCursor: SystemMouseCursors.click,
          contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
          leading: const Icon(
            Icons.watch_later,
          ),
          title: Text(
            DateFormat('HH:mm').format(_startDate),
          ),
          onTap: () async {
            final TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay(hour: _startTime.hour, minute: _startTime.minute),
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

                  _startDate = DateTime(_startDate.year, _startDate.month,
                      _startDate.day, _startTime.hour, _startTime.minute, 0);

                  _endTime = _startTime.plusMinutes(_appointmentDuration);
                  _endDate = DateTime(_endDate.year, _endDate.month,
                      _endDate.day, _endTime.hour, _endTime.minute, 0);
                },
              );
            }
          },
        ),
        const AppointmentDivider(),
        ListTile(
          mouseCursor: SystemMouseCursors.click,
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
                maxValue: 130,
                step: 15,
                itemHeight: 35,
                itemCount: 3,
                onChanged: (value) => setState(
                  () {
                    _appointmentDuration = value;
                    _endTime = _startTime.plusMinutes(_appointmentDuration);
                    _endDate = DateTime(_endDate.year, _endDate.month,
                        _endDate.day, _endTime.hour, _endTime.minute, 0);
                  },
                ),
                haptics: true,
              ),
            ],
          ),
          onTap: () async {},
        ),
        const AppointmentDivider(),
        ListTile(
          mouseCursor: SystemMouseCursors.click,
          contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
          leading: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                color: _currentColor),
            child: Icon(
              Icons.rectangle,
              color: _currentColor,
            ),
          ),
          title: Text(
            _currentColor == Colors.white
                ? 'Please choose a color'
                : '#${_currentColor.value.toRadixString(16).substring(2, 8)}',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: () async {
            // ignore: unused_local_variable
            var result = await showDialog<Widget>(
              context: context,
              barrierDismissible: true,
              useSafeArea: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  titlePadding: const EdgeInsets.all(10),
                  titleTextStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  title: const Center(
                    child: Text(
                      'Please choose a color for the appointment',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  content: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: MaterialPicker(
                      pickerColor: Colors.red,
                      onColorChanged: _chooseColor,
                      enableLabel: true,
                      portraitOnly: true,
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _changeColor(_chosenColor);
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        const AppointmentDivider(),
        ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(
            Icons.subject,
            color: Colors.grey,
          ),
          title: TextField(
            controller: TextEditingController(text: _notes),
            onChanged: (String value) {
              _notes = value;
            },
            enabled: true,
            keyboardType: TextInputType.text,
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
        const AppointmentDivider(),
      ],
    );
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
          backgroundColor:
              _currentColor == Colors.white ? Colors.blue : _currentColor,
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
              onPressed: () async {
                if (_currentColor == Colors.white) {
                  var snackBar = SnackBar(
                    backgroundColor: Colors.red,
                    content: Row(
                      children: const <Widget>[
                        Icon(Icons.warning),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Error: Please choose another color for the appointment.',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    duration: const Duration(seconds: 5),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                  return;
                }

                // Check if valid date.
                for (var appointment in _events.appointments!) {
                  if (_startDate.isAfter(appointment.from) &&
                      _startDate.isBefore(appointment.to) &&
                      appointment.eventName !=
                          _selectedAppointment!.eventName &&
                      appointment.description !=
                          _selectedAppointment!.description) {
                    var snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Row(
                        children: const <Widget>[
                          Icon(Icons.warning),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Error: Please choose another time for the appointment.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      duration: const Duration(seconds: 5),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                    return;
                  }
                }

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
                _events.notifyListeners(CalendarDataSourceAction.add, meetings);
                _selectedAppointment = null;

                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
          child: _getAppointmentEditor(context),
        ),
        floatingActionButton: _selectedAppointment == null
            ? Container()
            : FloatingActionButton(
                onPressed: () {
                  if (_selectedAppointment != null) {
                    _events.appointments!.removeAt(
                        _events.appointments!.indexOf(_selectedAppointment));
                    _events.notifyListeners(
                      CalendarDataSourceAction.remove,
                      <Meeting>[_selectedAppointment!],
                    );
                    _selectedAppointment = null;
                    Navigator.pop(context);
                  }
                },
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
                backgroundColor: Colors.red,
              ),
      ),
    );
  }
}
