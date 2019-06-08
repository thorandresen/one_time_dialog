library one_time_dialog;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A class for building an Alert Dialog a specific amount of times.
class OneTimeDialogState extends State<OneTimeDialog>{

  /// Build method for building the dialog.
  @override
  Widget build(BuildContext context) {
    // Returns a FutureBuilder that builds the Alert Dialog when data is fetched from SharedPrefs.
    return new FutureBuilder(
      future: _timesToShow(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.data != null) {
            _alertDialog();
          } else {
            return null;
          }
    });
  }

  /// This method gathers information from SharedPrefferences and checks wether to show the dialog or not.
  Future<bool> _timesToShow() async {
      return true;
  }

  /// This method creates and shows the AlertDialog to be shown.
  void _alertDialog(){
    showDialog(
        context: widget.context,
        builder: (BuildContext context) {
          AlertDialog(
            title: widget.title,
            content: widget.content,
            actions: <Widget>[
              widget.buttonOne,
              widget.buttonTwo,
              widget.neverShowAgainButton
            ],
          );
        }
    );
  }
}

/// A class for building an Alert Dialog a specific amount of times.
class OneTimeDialog extends StatefulWidget {
  final int amountOfTimesToShow; // Amount of times for the widget to be shown. Give this a value of 0 to keep showing.
  final BuildContext context;
  final Widget content; // The content of the dialog.
  final Widget title; // The title (if wanted) of the dialog.
  final FlatButton buttonOne; // The button furthest to the left
  final FlatButton buttonTwo; // The button next to that.
  final FlatButton neverShowAgainButton; // Have a button user can press to never show dialog again. This overwrites the amountOfTimesToShow!

  /// The constructor with all the params.
  const OneTimeDialog({
    @required this.amountOfTimesToShow,
    @required this.content,
    @required this.context,
    this.title,
    this.buttonOne,
    this.buttonTwo,
    this.neverShowAgainButton,
  }) : assert(amountOfTimesToShow != null),
  assert(content != null),
  assert(context != null);

  OneTimeDialogState createState() => new OneTimeDialogState();
}

