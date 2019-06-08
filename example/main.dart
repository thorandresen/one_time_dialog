import 'package:flutter/material.dart';
import 'package:one_time_dialog/one_time_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OneTimeDialog(amountOfTimesToShow: 1, content: Text('Test'), context: context),
    );
  }
}