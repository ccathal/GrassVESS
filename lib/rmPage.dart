import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/parseJsonFile.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/universalWidgets.dart';

import 'assessmentSummaryPage.dart';

double rmScore = 0.0;

///
/// Getter method for rm score.
///
double getRmScore() {
  return rmScore;
}

///
/// Setter method for rm score.
///
double setRmScore() {
  return rmScore = 0.0;
}

///
/// Class: RmScorePage
///
/// Main rm score page displays an instruction box and 3 cards corresponding
/// to the 3 rm scores. User can click on any of the 3 cards to indicate their
/// desired rm score.
///
/// Return: [Widget] of the rm score page.
///
class RmScorePage extends StatelessWidget {
  /// FutureBuilder to populate Rm Score Card.
  Widget _futureRmCardWidget(String rmStr) {
    return new FutureBuilder<dynamic>(
      future: readJson(rmStr, 'card'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RmCard(snapshot.data[0], snapshot.data[1], rmStr);
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

  @override

  /// Main rm score page widget.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('GrassVESS Assessment'),
      body: SingleChildScrollView(
        child: new Column(children: <Widget>[
          futureInstructionBoxWidget('rm_1'),
          _futureRmCardWidget('rm_1'),
          _futureRmCardWidget('rm_2'),
          _futureRmCardWidget('rm_3'),
        ]),
      ),
    );
  }
}

///
/// Class: RmCard & RmCardWidget
///
/// Populates a card with title, information and picture of single rm score.
///
/// Input:
///   [String] information of rm score description.
///   [String] picture of rm score card.
///   [String] title of rm score card.
/// Return: [Widget] of the rm score page.
///
class RmCard extends StatefulWidget {
  final String information;
  final String picture;
  final String title;

  RmCard(this.picture, this.information, this.title);

  RmCardWidget createState() => RmCardWidget(picture, information, title);
}

class RmCardWidget extends State {
  final String information;
  final String picture;
  final String title;

  RmCardWidget(this.picture, this.information, this.title);

  /// boolean value to know if rm card has been clicked on.
  bool clickedOn = false;

  @override
  Widget build(BuildContext context) {
    /// Split information string into list based on new line.
    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(information);

    /// Populate list of bullet pointed strings.
    var widgetList = <Widget>[];
    for (var text in lines) {
      /// Add list item
      widgetList.add(_bulletPointString(text));

      /// Add space between items
      widgetList.add(SizedBox(height: 5.0));
    }

    double rmNum = double.parse(title[title.length - 1]);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Card(
            color: clickedOn ? _getRmColorsClicked(rmNum) : _getRmColors(rmNum),
            child: InkWell(
                onTap: () async {
                  _rmCardStateSet(rmNum);
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child:
                            Image.asset('images/' + picture, fit: BoxFit.cover),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 32.0, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Rm Score ' + rmNum.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700)),
                              Padding(padding: EdgeInsets.only(bottom: 8.0)),
                              Column(children: widgetList),
                            ],
                          ))
                    ]))));
  }

  ///
  /// Returns string in bullet point format with necessary indentation as row.
  ///
  Row _bulletPointString(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("• "),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }

  ///
  /// Return color corresponding to rm score when clicked on.
  ///
  MaterialColor _getRmColorsClicked(double rmScore) {
    if (rmScore == 1.0) {
      return Colors.green;
    } else if (rmScore == 2.0) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  ///
  /// Return color corresponding to rm score.
  ///
  Color _getRmColors(double rmScore) {
    if (rmScore == 1.0) {
      return Colors.green[200];
    } else if (rmScore == 2.0) {
      return Colors.orange[200];
    } else {
      return Colors.red[200];
    }
  }

  ///
  /// Once rm card is clicked on change color, display for 1 second,
  /// and display next page in the application.
  ///
  void _rmCardStateSet(rmNum) async {
    setState(() {
      clickedOn = !clickedOn;
    });
    rmScore = rmNum;
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(Routes.createRoutingPage(MainAssessmentSummaryPage(rmScore)));
  }
}
