import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/parseJsonFile.dart';
import 'package:flutter_app/routes.dart';

import 'main.dart';

/// Main color of the application.
const PrimaryColor = const Color(0xFF0F70B7);

/// Enum for button click of below AlertDialog widget.
enum ConfirmAction { Cancel, Accept }

///
/// Method: asyncConfirmDialog
///
/// Method to display and read button click of AlertDialog widget.
///
/// Input:
///   [String] alertTitle of the AlertDialog Box.
///   [BuildContext] handle for the current widget.
/// Return: [Future<ConfirmAction>] enum of the corresponding button clicked.
///
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

///
/// Method: redoIconButtonWidget
///
/// Method to propagate Redo Icon Widget.
///
/// Input: [BuildContext] handle for the current widget.
/// Return: [IconButton] of Redo Icon Widget.
///
IconButton redoIconButtonWidget(BuildContext context) {
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

///
/// Method: appBarWidget
///
/// Method to propagate AppBar Widget.
///
/// Input:
///   [String] title of the app bar.
///   [bool] implyLeading for 'automaticallyImplyLeading' field of app bar.
/// Return: [AppBar].
///
AppBar appBarWidget(String title, {bool implyLeading = false}) {
  return AppBar(
      title: Text(title),
      backgroundColor: PrimaryColor,
      automaticallyImplyLeading: implyLeading);
}

///
/// Method: futureInstructionBoxWidget
///
/// Future method to read data to propagate the instruction box widget.
///
/// Input:
///   [String] linkName of the to get the instruction data for.
/// Return: [Widget] instruction box with populated data.
///
Widget futureInstructionBoxWidget(String linkName) {
  return new FutureBuilder<dynamic>(
    future:
    readJson(linkName, 'instruction'),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return InstructionBox(snapshot.data);
      } else if (snapshot.hasError) {
        return new Text("${snapshot.error}");
      }
      return new CircularProgressIndicator();
    },
  );
}

///
/// Class: InstructionBox
///
/// Class for the instruction box widget which is build using the input instruction string.
///
/// Input:
///   [String] instruction is the be used the fill the instruction box widget.
/// Return: [Widget] instruction box with populated data.
///
class InstructionBox extends StatelessWidget {

  final String instruction;
  InstructionBox(this.instruction);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 30.0, bottom: 5.0),
          padding: const EdgeInsets.all(15.0),
          decoration: _myBoxDecoration(),
          child: Text(
            instruction,
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
            left: 30,
            top: 20,
            child: Container(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              color: Color(0xFFF5F5F5),
              child: Text(
                'Instruction',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            )),
      ],
    );
  }

  ///
  /// Method returns the box decorator for the instruction box widget.
  ///
  BoxDecoration _myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: PrimaryColor, width: 2.0),
      borderRadius:
      BorderRadius.all(Radius.circular(5.0)
      ),
    );
  }
}

///
/// Method to populate a SnackBar widget with input String [snackText].
///
Widget makeSnackBar(String snackText) {
   return SnackBar(
    content: Text(snackText),
  );
}