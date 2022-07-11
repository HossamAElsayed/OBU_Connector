import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:obu_connector/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');

  // runApp(MyApp());
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}
