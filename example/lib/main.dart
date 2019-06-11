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
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Reload button.
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage())), child: Text('Reload page!')),
            ],
          ),
          // The dialog
          OneTimeDialog(
            amountOfTimesToShow: 1,
            title: Text('Data policy'),
            content: Text('We are gathering personal data about you!'),
            actions: <Widget>[
              new FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
            ],
            context: context,
            id: 'UniqueID!2',
          ),
        ],
      ),
    );
  }
}
