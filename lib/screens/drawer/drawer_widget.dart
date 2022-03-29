import 'package:flutter/material.dart';
import 'package:flutter_provider/models/drawer_state_info.dart';
import 'package:flutter_provider/screens/calendar/appointment_divider.dart';
import 'package:flutter_provider/screens/drawer/drawer_item.dart';
import 'package:flutter_provider/services/auth.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({
    Key? key,
  }) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 8,
          ),
          DrawerItem(
            text: 'SH Dent',
            icon: Icons.arrow_back_ios_new,
            color: Colors.blue,
          ),
          const SizedBox(
            height: 8,
          ),
          const AppointmentDivider(),
          const SizedBox(
            height: 8,
          ),
          DrawerItem(
            text: 'Kalendar',
            icon: Icons.calendar_month,
            color: Colors.red,
            onCallBack: () {
              Provider.of<DrawerStateInfo>(context, listen: false)
                  .setCurrentDrawer('calendar');
            },
          ),
          const SizedBox(
            height: 8,
          ),
          DrawerItem(
            text: 'Doktori',
            icon: Icons.local_hospital,
            color: Colors.blue,
            onCallBack: () {
              Provider.of<DrawerStateInfo>(context, listen: false)
                  .setCurrentDrawer('doctors');
            },
          ),
          const SizedBox(
            height: 8,
          ),
          DrawerItem(
            text: 'Pacijenti',
            icon: Icons.list,
            color: Colors.green,
            onCallBack: () {
              Provider.of<DrawerStateInfo>(context, listen: false)
                  .setCurrentDrawer('patients');
            },
          ),
          DrawerItem(
            text: 'Postavke',
            icon: Icons.settings,
            color: Colors.grey,
            onCallBack: () {
              Provider.of<DrawerStateInfo>(context, listen: false)
                  .setCurrentDrawer('settings');
              // Navigator.pushNamed(context, '/settings');
            },
          ),
          DrawerItem(
            text: 'Odjavi se',
            icon: Icons.exit_to_app,
            color: Colors.black,
            onCallBack: () async {
              Provider.of<DrawerStateInfo>(context, listen: false)
                  .setCurrentDrawer('calendar');
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
