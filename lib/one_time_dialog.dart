library one_time_dialog;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class for building an Alert Dialog a specific amount of times.
class OneTimeDialogState extends State<OneTimeDialog>{
  SharedPreferences prefs; // Prefs variable.
  DialogShowStrategy _dialogShowStrategy;
  LocalAmountStrategy _localAmountStrategy;
  int localAmount;

  /// Build method for building the dialog.
  @override
  Widget build(BuildContext context) {
    // Shows the dialog after a duration of 0.
    Future.delayed(Duration.zero, () => _alertDialog());

    // Returns a Container (Same as returning nothing). This is because the dialog is shown with another method that renders it ontop of everything else.
    return new Container();
  }

  /// This method gathers information from SharedPrefferences and checks wether to show the dialog or not.
  Future<bool> _timesToShow() async {
      // If the id doesn't exist it will make it as a shared preferences.
      if (prefs.getInt(widget.id) == null || prefs.getInt(widget.id) == "" || prefs.getInt(widget.id) == {}) {
        prefs.setInt(widget.id, widget.amountOfTimesToShow);
      }

      localAmount = prefs.getInt(widget.id);
      _showDialogStrategyChooser(); // Chooses the correct showDialogStrategy.
      _localAmountStrategyChooser(); // Chooses the correct localAmountStrategy.

      // Then take the value and see if its more than 0, if it is then we decrement it by one and show the dialog. If there is offset and it is 0, then we increment. Else just return false.
      if(_localAmountStrategy.localAmountCondition(localAmount)) {
          prefs.setInt(widget.id, localAmount - 1);
          return _dialogShowStrategy.shouldShowDialog(widget.offset);
        }
      else{
        return false;
      }
  }

  /// This method creates and shows the AlertDialog to be shown.
  void _alertDialog() async{
    prefs = await SharedPreferences.getInstance();

    // Show dialog if amountOfTimes is 0 and offset is not set.
    bool amountOfTimesEqualsZeroAndOffsetIsNull = widget.amountOfTimesToShow == 0 && widget.offset == null;
    if(amountOfTimesEqualsZeroAndOffsetIsNull){
      _showDialog();
      return;
    }

    // Test if the dialog has been shown the right amount of times and do calculations on offset/amounts.
    bool timesToShowGreaterThanZero = await _timesToShow();
    if(timesToShowGreaterThanZero) {
      _showDialog();
    }
  }

  /// This method shows and creates the dialog.
  void _showDialog(){
    showDialog(
        context: widget.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: widget.title,
            content: widget.content,
            titlePadding: widget.titlePadding,
            contentPadding: widget.contentPadding,
            backgroundColor: widget.backgroundColor,
            contentTextStyle: widget.contentTextStyle,
            elevation: widget.elevation,
            key: widget.key,
            semanticLabel: widget.semanticLabel,
            shape: widget.shape,
            titleTextStyle: widget.titleTextStyle,
            actions: widget.actions
          );
        }
    );
  }

  /// Method that chooses what ShowDialog strategy to use.
  void _showDialogStrategyChooser(){
    if(widget.offset == null || widget.offset < 1) {
      _dialogShowStrategy = new NormalDialogShowStrategy();
    }
    else{
      _dialogShowStrategy = new OffsetDialogShowStrategy();
      _dialogShowStrategy.setLocalAmount(localAmount);
    }
  }

  /// Method that chooses what LocalAmount strategy to use.
  void _localAmountStrategyChooser(){
    if(widget.amountOfTimesToShow > 0) {
      _localAmountStrategy = new NormalLocalAmountStrategy();
    }
    else if(widget.amountOfTimesToShow == 0 && widget.offset != null){
      _localAmountStrategy = new ZeroLocalAmountStrategy();
    }
  }
}

/// A class for building an Alert Dialog a specific amount of times.
class OneTimeDialog extends StatefulWidget {
  final int amountOfTimesToShow; // Amount of times for the widget to be shown. Give this a value of 0 to keep showing (Works with offset).
  final String id; // An ID that is used in sharedprefferences. Make this unique.
  final BuildContext context; // The context in which the dialog should be build.
  final int offset; // To show the dialog within an offset. If the offset is 2, the dialog will only be shown every second time the package is trying to be build.
  final Widget content; // The content of the dialog.
  final Widget title; // The title (if wanted) of the dialog.
  final List<Widget> actions; // List of widget (Most commonly used for buttons).
  final Color backgroundColor; // The background color of the surface of this Dialog.
  final EdgeInsetsGeometry contentPadding; // Padding around the content.
  final TextStyle contentTextStyle; // Style for the text in the content of this AlertDialog.
  final double elevation; // The z-coordinate of this Dialog.
  final String semanticLabel; // The semantic label of the dialog used by accessibility frameworks to announce screen transitions when the dialog is opened and closed.
  final ShapeBorder shape; // The shape of this dialog's border.
  final EdgeInsetsGeometry titlePadding; // Padding around the title.
  final TextStyle titleTextStyle; // Style for the text in the title of this AlertDialog.
  final Key key; // Controls how one widget replaces another widget in the tree.

  /// The constructor with all the params.
  const OneTimeDialog({
    @required this.amountOfTimesToShow,
    @required this.context,
    @required this.id,
    this.content,
    this.offset,
    this.title,
    this.actions,
    this.backgroundColor,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.contentTextStyle,
    this.elevation,
    this.semanticLabel,
    this.shape,
    this.titlePadding,
    this.titleTextStyle,
    this.key,
  }) : assert(amountOfTimesToShow != null && amountOfTimesToShow >= 0),
  assert(context != null),
  assert(id != null),
  assert(offset == null || offset > 1);

  OneTimeDialogState createState() => new OneTimeDialogState();
}

/// % ------------ DIALOG SHOW STRATEGY ------------ %

/// A class that serves as a strategy pattern for choosing whether this is done with offset or not.
abstract class DialogShowStrategy {
  bool shouldShowDialog(int offset); // The method that chooses whether to return true of false and show the dialog.
  void setLocalAmount(int localAmount); // Used to retrieve the localamount from the other class. Only used in offset.
}

/// This class always shows the dialog, because there is no offset.
class NormalDialogShowStrategy extends DialogShowStrategy {
  @override
  bool shouldShowDialog(int offset) {
    return true;
  }

  @override
  void setLocalAmount(int localAmount) {
    // Doesn't need to be implemented in NormalDialog.
  }
}

/// This class only shows the dialog if the amount % offset equals 0, which means it is its turn to show.
class OffsetDialogShowStrategy extends DialogShowStrategy {
  int localAmount;
  @override
  bool shouldShowDialog(int offset) {
        if (localAmount % offset == 0) {
          return true;
        }
        else {
          return false;
        }
  }

  void setLocalAmount(int localAmount){
    this.localAmount = localAmount;
  }
}


/// A class that serves as a strategy pattern for calculating the local amount.
abstract class LocalAmountStrategy {
  bool localAmountCondition(int localAmount);
}

/// % ------------ LOCAL AMOUNT STRATEGY ------------ %

/// A class that returns true if local amount is greater than 0.
class NormalLocalAmountStrategy extends LocalAmountStrategy {
  @override
  bool localAmountCondition(int localAmount) {
    if(localAmount > 0) {
      return true;
    } else {
      return false;
    }
  }
}

/// A class that always just returns true.
class ZeroLocalAmountStrategy extends LocalAmountStrategy {
  @override
  bool localAmountCondition(int localAmount) {
    return true;
  }
}