import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/parseJsonFile.dart';
import 'package:flutter_app/routes.dart';

import 'assessmentPage.dart';
import 'assessmentSummaryPage.dart';

double rmScore = 0.0;

double getRmScore() {
  return rmScore;
}

double setRmScore() {
  return rmScore = 0.0;
}

/*
  Main class for the Rm Score Page.
 */

class RmScorePage extends StatelessWidget {

  // FutureBuilder to populate Rm Score Card.
  Widget futureRmCardWidget(String rmStr) {
    return new FutureBuilder<List<dynamic>>(
      future: readJsonCard(rmStr),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RmCard(
              snapshot.data[1], snapshot.data[0], rmStr);
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

  @override
  // Main Page Widget.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('GrassVESS Assessment'),
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: new Column(children: <Widget>[
          futureInstructionBoxWidget('rm_1'),
          futureRmCardWidget('rm_1'),
          futureRmCardWidget('rm_2'),
          futureRmCardWidget('rm_3'),
        ]),
      ),
    );
  }
}

/*
  Profile Card Widget
 */

class RmCard extends StatefulWidget {
  final String information;
  final String picture;
  final String title;

  RmCard(this.picture, this.information, this.title);

  RmCardWidget createState() =>
      RmCardWidget(picture, information, title);
}

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
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
}


class RmCardWidget extends State {
  final String information;
  final String picture;
  final String title;

  RmCardWidget(this.picture, this.information, this.title);

  bool clickedOn = false;

  @override
  Widget build(BuildContext context) {

    List<String> lines;
    LineSplitter ls = new LineSplitter();
    lines = ls.convert(information);

    var widgetList = <Widget>[];
    for (var text in lines) {
      // Add list item
      widgetList.add(UnorderedListItem(text));
      // Add space between items
      widgetList.add(SizedBox(height: 5.0));
    }



    double rmNum = double.parse(title[title.length - 1]);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Card(
            color: clickedOn
                ? _getRmColors(double.parse(title[title.length - 1]))
                : Colors.white60,
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
                        child: Image.asset('images/' + picture,
                            fit: BoxFit.cover),
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
                              // Text(information,
                              //     style: TextStyle(
                              //         color: Colors.black, fontSize: 16),
                              //     textAlign: TextAlign.start),
                            Column(children: widgetList),
                            ],
                          ))
                    ]))));
  }

  MaterialColor _getRmColors(rmScore) {
    if (rmScore == 1.0) {
      return Colors.green;
    } else if (rmScore == 2.0) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  _rmCardStateSet(rmNum) async {
    setState(() {
      clickedOn = !clickedOn;
    });
    rmScore = rmNum;
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pop();
    Navigator.of(context).push(
        Routes.createRoutingPage(AssessmentSummaryPage(rmScore)));
  }
}
