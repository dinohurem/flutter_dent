import 'package:flutter/material.dart';

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
          ListTile(
            leading: const Icon(
              Icons.arrow_back_ios_new,
              size: 25,
              color: Colors.blue,
            ),
            title: const Text(
              'SH Dent',
              style: TextStyle(
                fontSize: 25,
                color: Colors.blue,
              ),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_month,
              size: 25,
              color: Colors.red,
            ),
            title: const Text(
              'Kalendar',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          ListTile(
            leading: const Icon(
              Icons.local_hospital,
              size: 25,
              color: Colors.blue,
            ),
            title: const Text(
              'Doktori',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          ListTile(
            leading: const Icon(
              Icons.list,
              size: 25,
              color: Colors.green,
            ),
            title: const Text(
              'Pacijenti',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 25,
              color: Colors.grey,
            ),
            title: const Text(
              'Postavke',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
