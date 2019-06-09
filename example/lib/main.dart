import 'package:flutter/material.dart';
import 'package:one_time_dialog/one_time_dialog.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
        centerTitle: true,
      ),
      body: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          OneTimeDialog(
              amountOfTimesToShow: 2,
              content: Text('xd'),
              context: context,
              id: 'unique5')
        ],
      )
    );
  }
}
