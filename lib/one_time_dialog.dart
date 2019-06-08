library one_time_dialog;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A class for building an Alert Dialog a specific amount of times.
class OneTimeDialogState extends State<OneTimeDialog>{

  /// Build method for building the dialog.
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

/// A class for building an Alert Dialog a specific amount of times.
class OneTimeDialog extends StatefulWidget {
  final int amountOfTimesToShow; // Amount of times for the widget to be shown. Give this a value of 0 to keep showing.
  final Widget content; // The content of the dialog.
  final Text title; // The title (if wanted) of the dialog.
  final FlatButton buttonOne; // The button furthest to the left
  final FlatButton buttonTwo; // The button next to that.
  final bool neverShowAgainButton; // Have a button user can press to never show dialog again. This overwrites the amountOfTimesToShow!

  /// The constructor with all the params.
  const OneTimeDialog({
    @required this.amountOfTimesToShow,
    @required this.content,
    this.title,
    this.buttonOne,
    this.buttonTwo,
    this.neverShowAgainButton,
  }) : assert(amountOfTimesToShow != null),
  assert(content != null);

  OneTimeDialogState createState() => new OneTimeDialogState();
}

