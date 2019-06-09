library one_time_dialog;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class for building an Alert Dialog a specific amount of times.
class OneTimeDialogState extends State<OneTimeDialog>{
  SharedPreferences prefs; // Prefs variable.

  /// Build method for building the dialog.
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => _alertDialog());
    return new Container();
  }

  /// This method gathers information from SharedPrefferences and checks wether to show the dialog or not.
  Future<bool> _timesToShow() async {
    print('_timesToShow is run.');

      if (prefs.getInt(widget.id) == null || prefs.getInt(widget.id) == "" || prefs.getInt(widget.id) == {}) {
        prefs.setInt(widget.id, widget.amountOfTimesToShow);
        print('the prefs are empty.');
      }

      int localAmount = prefs.getInt(widget.id);
      if(localAmount > 0) {
          prefs.setInt(widget.id, localAmount - 1);
          print('Amount of times was decremented to: ' + (localAmount--).toString());
          return true;
        }
      else{
        return false;
      }
  }

  /// This method creates and shows the AlertDialog to be shown.
  void _alertDialog() async{
    prefs = await SharedPreferences.getInstance();
    print('_alertDialog is run.');

    // Show dialog if amountOfTimes is 0.
    if(widget.amountOfTimesToShow == 0){
      _showDialog();
      return;
    }

    // Test if the dialog has been shown the right amount of times.
    if(await _timesToShow()) {
      _showDialog();
    }
    else{
      // Do nothing...
    }
  }

  void _showDialog(){
    showDialog(
        context: widget.context,
        builder: (BuildContext context) {
          return AlertDialog(
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
  final String id; // An ID that is used in sharedprefferences. Make this unique.
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
    @required this.id,
    this.title,
    this.buttonOne,
    this.buttonTwo,
    this.neverShowAgainButton,
  }) : assert(amountOfTimesToShow != null),
  assert(content != null),
  assert(context != null);

  OneTimeDialogState createState() => new OneTimeDialogState();
}

