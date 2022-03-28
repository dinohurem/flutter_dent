import 'package:flutter/material.dart';

class AppointmentDivider extends StatelessWidget {
  const AppointmentDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1.0,
      thickness: 1,
    );
  }
}
