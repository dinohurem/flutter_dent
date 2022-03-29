import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final void Function()? onCallBack;
  // ignore: prefer_const_constructors_in_immutables
  DrawerItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    this.onCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          icon,
          size: 25,
          color: color,
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        onTap: text == 'SH Dent'
            ? () {
                Navigator.pop(context);
              }
            : onCallBack);
  }
}
