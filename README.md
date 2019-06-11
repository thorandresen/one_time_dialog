# one_time_dialog

A flutter package for showing a dialog X amount of times to the user. This package uses SharedPreferences to make sure dialogs aren't shown too many times.

The package can be used for showing some information to the user the first time they open the page. It can also be used with offset to show the user a dialog once in a while (like every fifth or tenth timewhen the user opens the page).

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

#### Example gif
![](one_time_dialog_gif.gif)

### Constructor (The ones unique for this packet)
`amountOfTimesToShow` => Amount of times for the widget to be shown. Give this a value of 0 to keep showing (Works with offset).  
`id` => An ID that is used in sharedprefferences. Make this unique.  
`offset` => To show the dialog within an offset. If the offset is 2, the dialog will only be shown every second time the package is trying to be build.  
   

