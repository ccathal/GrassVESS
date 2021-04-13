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
String gpsField;
DateTime dateTimeField;

String getGpsField() {
  return gpsField;
}

void setGpsField() {
  gpsField = 'null: null';
}

String getDescriptionField() {
  return descriptionField;
}

void setDescriptionField() {
  descriptionField = 'null';
}

DateTime getDateTimeField() {
  return dateTimeField;
}

void setDateTimeField() {
  dateTimeField = null;
}

/*
  Main Assessment Summary Page.
 */

class AssessmentSummaryPage extends StatelessWidget {
  final double rmScore;

  AssessmentSummaryPage(this.rmScore);

  final double sqScore = getSqScore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('GrassVESS Assessment'),
          automaticallyImplyLeading: false),
      body: Center(
        child: FutureBuilder<Position>(
          future: determinePosition(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Position pos = snapshot.data;
              gpsField = '${pos.latitude}: ${pos.longitude}';
              return new Column(children: <Widget>[
                ShowSummaryInformation(sqScore, rmScore),
              ]);
            } else if (snapshot.hasError) {

              final snackBar = SnackBar(
                content: Text(snapshot.error.toString()),
              );

              gpsField = 'null: null';
              return new Column(children: <Widget>[
                ShowSummaryInformation(sqScore, rmScore, snackBar),
              ]);
            }
            return new CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

/*
  Widget to show Assessment Summary Information.
 */

class ShowSummaryInformation extends StatelessWidget {
  final double sqScore;
  final double rmScore;
  final SnackBar snackBar;

  ShowSummaryInformation(this.sqScore, this.rmScore, [this.snackBar]);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,() {
      if(snackBar != null) { // display snackbar if position error occurs
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    dateTimeField = DateTime.now();
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Spacer(),
                  _textFormSummary('Sq Score ' + sqScore.toString(), 'Sq Score'),
                  Spacer(),
                  _textFormSummary('Rm Score ' + rmScore.toString(), 'Rm Score'),
                  Spacer(),
                  _textFormSummary(DateTime.now().toString(), 'Date & Time'),
                  Spacer(),
                  _textFormSummary(getGpsField(), 'GPS (longitude: latitude)'),
                  Spacer(),
                  TextFormField(
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
                    maxLength: 50,
                    onChanged: (String val) {
                      descriptionField = val;
                    },
                  ),
                  Spacer(),
                  SummaryButtonPanel(
                      sqScore, rmScore, gpsField, descriptionField),
                  Spacer(),
                ])));
  }

  _textFormSummary(initialVal, label) {
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

/*
  Assessment Summary Button Panel.
 */

class SummaryButtonPanel extends StatelessWidget {
  final double sqScore;
  final double rmScore;
  final String gps;
  final String description;

  SummaryButtonPanel(this.sqScore, this.rmScore, this.gps, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
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
          SizedBox(
            width: 130,
            height: 60,
            child: TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                  textStyle:
                  TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
              child: Text('Save'),
              onPressed: () {
                _saveEntry(context);
              },
            ),
          ),
          SizedBox(
            width: 130,
            height: 60,
            child: TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    textStyle:
                    TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
                child: Text('Email'),
                onPressed: () async {
                  String emailBody = 'Sq Score: ${getSqScore().toString()}\nRm Score: ${getRmScore().toString()}\nDateTime: ${getDateTimeField().toString()}\nGPS (long, lat): ${getGpsField()}\nDescription: ${getDescriptionField()}';
                  bool emailConfigured = await checkLaunchURL('cathalcorbett3@gmail.com');

                  if(emailConfigured) {
                    _saveEntry(context);
                  }

                  launchMailURL(
                      'cathalcorbett3@gmail.com',
                      'GrassVESS Assessment Submission',
                      emailBody,
                      context);
                }),

          ),
          redoIconButtonWidget(context)
        ]);
  }

  void _saveEntry(context) {
    String saveEntry =
        '${getSqScore().toString()},${getRmScore().toString()},${getDateTimeField().toString()},${getGpsField()},${getDescriptionField()}\n';
    amendCsvAssessmentFile(writeString: saveEntry);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).push(Routes.createRoutingPage(MyApp()));
  }
}