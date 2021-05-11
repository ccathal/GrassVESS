import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/rmPage.dart';
import 'package:flutter_app/sqPage.dart';
import 'package:flutter_app/parseAssessmentsFile.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/location.dart';
import 'package:flutter_app/universalWidgets.dart';
import 'package:flutter_app/urlLauncher.dart';
import 'package:geolocator/geolocator.dart';

import 'main.dart';

String descriptionField;

///
/// Method: getDescriptionField
///
/// Local getter method for the GPS location.
///
/// Return: [String] corresponding assessment description input by user.
///
String _getDescriptionField() {
  return descriptionField;
}

///
/// Method: setGpsField
///
/// Global setter method for the Description field.
/// Ensures the Description field string is null.
///
/// Return: [void].
///
void setDescriptionField() {
  descriptionField = 'none';
}


///
/// Class: AssessmentSummaryPage
///
/// FutureBuilder to retrieve data to populate the main assessment summary page.
///
/// Input: [double] of the rm score.
/// Return: [Widget] of the assessment summary page.
///
class MainAssessmentSummaryPage extends StatelessWidget {

  /// Retrieve sq score.
  final double sqScore = getSqScore();
  final double rmScore;
  MainAssessmentSummaryPage(this.rmScore);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget('GrassVESS Assessment'),
      body: Center(
        /// Get GPS location.
        child: FutureBuilder<Position>(
          future: determinePosition(),
          builder: (context, snapshot) {
            /// if valid GPS location returned.
            if (snapshot.hasData) {
              Position pos = snapshot.data;
              String gpsField = '${pos.latitude}: ${pos.longitude}';
              return new Column(children: <Widget>[
                progressIndicatorWidget(0.9),
                ShowSummaryInformation(sqScore, rmScore, gpsField),
              ]);
            }
            /// if error occurred in retrieving the GPS.
            else if (snapshot.hasError) {
              SnackBar snackBar = makeSnackBar(snapshot.error.toString());
              String gpsField = 'null: null';
              return new Column(children: <Widget>[
                progressIndicatorWidget(0.9),
                ShowSummaryInformation(sqScore, rmScore, gpsField, snackBar),
              ]);
            }
            return new CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

///
/// Class: ShowSummaryInformation
///
/// Displays the main assessment summary page consisting of
/// sq score, rm score, date time, gps location and
/// and input description field for the application user.
///
/// Input:
///   [double] of the rm score.
///   [double] of the sq score.
///   [SnackBar] widget if error message needs to be displayed in retrieving GPS.
/// Return: [Widget] of the assessment summary page.
///
class ShowSummaryInformation extends StatelessWidget {

  final double sqScore;
  final double rmScore;
  final String gpsField;
  final SnackBar snackBar;
  ShowSummaryInformation(this.sqScore, this.rmScore, this.gpsField, [this.snackBar]);

  @override
  Widget build(BuildContext context) {

    /// Display SnackBar if GPS error occurs.
    Future.delayed(Duration.zero,() {
      if(snackBar != null) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    DateTime dateTimeField = DateTime.now();

    return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Spacer(),
                  /// Input field for user to enter description.
                  /// User is limited to 50 characters.
                  /// User cannot enter commas (,) as the storage file is in CSV format.
                  TextFormField(
                    maxLength: 50,
                    inputFormatters: [FilteringTextInputFormatter.deny(',')],
                    //controller: TextEditingController(text: text),
                    readOnly: false,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Your Description',
                    ),
                    onChanged: (String val) {
                      descriptionField = val;
                    },
                  ),
                  Spacer(),
                  _textFormSummary('Sq Score ' + sqScore.toString(), 'Sq Score'),
                  Spacer(),
                  _textFormSummary('Rm Score ' + rmScore.toString(), 'Rm Score'),
                  Spacer(),
                  _textFormSummary(DateTime.now().toString(), 'Date & Time'),
                  Spacer(),
                  _textFormSummary(gpsField, 'GPS (longitude: latitude)'),
                  Spacer(),
                  SummaryButtonPanel(
                      sqScore, rmScore, gpsField, dateTimeField),
                  Spacer(),
                ])));
  }

  ///
  /// Method: _textFormSummary
  ///
  /// TextFormField widget the displays an initial value and label.
  ///
  /// Input:
  ///   [String] initialVal is the text field initial value.
  ///   [String] label is the text field label.
  /// Return: [TextFormField] of the initial value and label.
  ///
  TextFormField _textFormSummary(String initialVal, String label) {
    return TextFormField(
      readOnly: true,
      initialValue: initialVal,
      style: TextStyle(fontSize: 16.0, color: Colors.black),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: label,
      ),
    );
  }
}

///
/// Class: SummaryButtonPanel
///
/// Assessment summary button panel.
///
/// Input:
///   [double] of the rm score.
///   [double] of the sq score.
///   [String] of the gps location.
///   [DateTime] of the date and time.
/// Return: [Widget] of the summary button panel.
///
class SummaryButtonPanel extends StatelessWidget {

  final double sqScore, rmScore;
  final String gps;
  final DateTime dateTime;
  SummaryButtonPanel(this.sqScore, this.rmScore, this.gps, this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /// Back Button.
          IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            tooltip: 'Go Back',
            onPressed: () {
              setRmScore();
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(Routes.createRoutingPage(RmScorePage()));
            },
          ),
          /// Save Assessment Button.
          Expanded( child:SizedBox(
            height: 60,
            child: TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                  textStyle:
                  TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
              child: Text('Save'),
              onPressed: () {
                _saveAssessmentEntry(context);
              },
            ),
          )),
          SizedBox(width:5),
          /// Email Button.
          Expanded( child: SizedBox(
            height: 60,
            child: TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: PrimaryColor,
                    textStyle:
                    TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
                child: Text('Email'),
                onPressed: () async {
                  String emailBody = 'Sq Score: ${sqScore.toString()}\nRm Score: ${rmScore.toString()}\nDateTime: ${dateTime.toString()}\nGPS (long, lat): $gps\nDescription: ${_getDescriptionField()}';
                  bool emailConfigured = await checkLaunchMailURL('cathalcorbett3@gmail.com');

                  if(emailConfigured) {
                    _saveAssessmentEntry(context);
                  }

                  launchMailURL(
                      'grassland.info.temp@gmail.com',
                      'GrassVESS Assessment Submission',
                      emailBody, context);
                }),

          )),
          /// Redo Assessment Button.
          redoIconButtonWidget(context)
        ]);
  }

  ///
  /// Method: _saveAssessmentEntry
  ///
  /// Saves the assessment to storage and displays the main application home page.
  ///
  /// Input:
  /// [BuildContext] handle for the current widget.
  /// Return: [void].
  ///
  void _saveAssessmentEntry(BuildContext context) {
    String saveEntry =
        '${sqScore.toString()},${rmScore.toString()},${dateTime.toString()},$gps,${_getDescriptionField()}\n';
    amendCsvAssessmentFile(writeString: saveEntry);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).push(Routes.createRoutingPage(MyApp()));
  }
}