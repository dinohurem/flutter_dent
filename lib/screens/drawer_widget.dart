import 'package:flutter/material.dart';
import 'package:flutter_provider/screens/appointment_divider.dart';
import 'package:flutter_provider/screens/drawer_item_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 8,
          ),
          DrawerItemWidget(
            text: 'SH Dent',
            icon: Icons.arrow_back_ios_new,
            color: Colors.blue,
            callback: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          const AppointmentDivider(),
          const SizedBox(
            height: 8,
          ),
          DrawerItemWidget(
            text: 'Kalendar',
            icon: Icons.calendar_month,
            color: Colors.red,
            callback: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          DrawerItemWidget(
            text: 'Doktori',
            icon: Icons.local_hospital,
            color: Colors.blue,
            callback: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          DrawerItemWidget(
            text: 'Pacijenti',
            icon: Icons.list,
            color: Colors.green,
            callback: () {
              Navigator.pop(context);
            },
          ),
          DrawerItemWidget(
            text: 'Postavke',
            icon: Icons.settings,
            color: Colors.grey,
            callback: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
