# one_time_dialog

A flutter package for showing a dialog X amount of times to the user. This package uses SharedPreferences to make sure dialogs aren't shown too many times.

## Usage

To use this plugin, add `one_time_dialog` as dependency to pubspec.yaml file.

### Example

The code below returns a widget and can be added anywhere this is allowed. However it only returns an empty container (So it won't ruin your UI). It uses showDialog() to show the dialog.

```
import 'package:flutter/material.dart';
import 'package:one_time_dialog/one_time_dialog.dart';

OneTimeDialog(
  amountOfTimesToShow: 1,
  title: Text('Data policy'),
  content: Text('We are gathering personal data about you!'),
  actions: <Widget>[
    new FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
  ],
  context: context,
  id: 'AUniqueID',
),
```

### Constructor
  `amountOfTimesToShow` => Amount of times for the widget to be shown. Give this a value of 0 to keep showing (Works with offset).
  

