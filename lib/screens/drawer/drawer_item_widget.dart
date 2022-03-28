import 'package:flutter/material.dart';

class DrawerItemWidget extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Widget destination;
  const DrawerItemWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.destination,
  }) : super(key: key);

  @override
  State<DrawerItemWidget> createState() => _DrawerItemWidgetState();
}

class _DrawerItemWidgetState extends State<DrawerItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.icon,
        size: 25,
        color: widget.color,
      ),
      title: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
