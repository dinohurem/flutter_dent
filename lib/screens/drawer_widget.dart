import 'package:flutter/material.dart';
import 'package:flutter_provider/screens/calendar/appointment_divider.dart';
import 'package:flutter_provider/screens/drawer_item_widget.dart';
import 'package:flutter_provider/screens/patients_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          SizedBox(
            height: 8,
          ),
          DrawerItemWidget(
            text: 'SH Dent',
            icon: Icons.arrow_back_ios_new,
            color: Colors.blue,
            destination: PatientsScreen(),
          ),
          SizedBox(
            height: 8,
          ),
          AppointmentDivider(),
          SizedBox(
            height: 8,
          ),
          DrawerItemWidget(
            text: 'Kalendar',
            icon: Icons.calendar_month,
            color: Colors.red,
            destination: PatientsScreen(),
          ),
          SizedBox(
            height: 8,
          ),
          DrawerItemWidget(
            text: 'Doktori',
            icon: Icons.local_hospital,
            color: Colors.blue,
            destination: PatientsScreen(),
          ),
          SizedBox(
            height: 8,
          ),
          DrawerItemWidget(
            text: 'Pacijenti',
            icon: Icons.list,
            color: Colors.green,
            destination: PatientsScreen(),
          ),
          DrawerItemWidget(
            text: 'Postavke',
            icon: Icons.settings,
            color: Colors.grey,
            destination: PatientsScreen(),
          ),
        ],
      ),
    );
  }
}
