import 'package:flutter/material.dart';

const mainEndPoint = '192.168.1.3';

void showASnackBar(
  context,
  String msg, {
  double fontSize = 14,
  Color color = Colors.white,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
          content: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize, color: color),
      )),
    );
}

final List availableDevices = [
  [
    "assets/images/connect_device.png",
    'Device 1',
  ],
];
