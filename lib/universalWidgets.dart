import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/routes.dart';

import 'main.dart';

/*
  Alert Box Widget.
 */

enum ConfirmAction { Cancel, Accept }

Future<ConfirmAction> asyncConfirmDialog(
    String alertTitle, BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(alertTitle),
        content: const Text('Do you wish to continue?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Cancel);
            },
          ),
          TextButton(
            child: const Text('Continue'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Accept);
            },
          )
        ],
      );
    },
  );
}

/*
  Redo Icon Widget.
 */

redoIconButtonWidget(context) {
  return IconButton(
      icon: Icon(Icons.autorenew),
      tooltip: 'Redo Assessment',
      onPressed: () async {
        final ConfirmAction action =
        await asyncConfirmDialog('Redo Assessment', context);

        if (action == ConfirmAction.Accept) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Route route = Routes.createRoutingPage(MyApp());
          Navigator.of(context).push(route);
        }
      }
  );
}