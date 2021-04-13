import 'package:flutter/material.dart';
import 'package:flutter_app/parseJsonFile.dart';
import 'package:flutter_app/tree.dart';
import 'package:flutter_app/universalWidgets.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/rmPage.dart';
import 'assessmentPage.dart';
import 'main.dart';

double sqScore = 0.0;

double getSqScore() {
  return sqScore;
}

void setSqScore() {
  sqScore = 0.0;
}

/*
  Main Sq Score Page.
 */

class SqScorePage extends StatelessWidget {

  final LinkdList linkedList;

  SqScorePage(this.linkedList);

  Widget futureScoreSqTextButton() {
    return new FutureBuilder<String>(
      future:
      readJsonInformation(linkedList.getPreviousElement().getLinkName()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DisplayButtonPanelSqScore(snapshot.data, linkedList);
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('GrassVESS Assessment'),
          automaticallyImplyLeading: false),
      body: Center(
        child: new Stack(children: <Widget>[
          Positioned(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: futureInstructionBoxWidget(linkedList.getPreviousElement().getLinkName()))),
          Positioned(
              child: Align(
                  alignment: Alignment.center,
                  child: futureScoreSqTextButton())),
          Positioned(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: ButtonPanelSqSubmit(linkedList)))),
        ]),
      ),
    );
  }
}

/*
  Sq Page Display Button Panel.
 */

class DisplayButtonPanelSqScore extends StatefulWidget {
  final LinkdList linkedList;
  final String information;

  DisplayButtonPanelSqScore(this.information, this.linkedList);

  DisplayButtonPanelSqScoreWidget createState() =>
      DisplayButtonPanelSqScoreWidget(information, linkedList);
}

class DisplayButtonPanelSqScoreWidget extends State {
  String information;
  LinkdList linkedList;

  DisplayButtonPanelSqScoreWidget(information, linkedList) {
    this.information = information;
    this.linkedList = linkedList;
  }

  String buttonText;

  @override
  void initState() {
    super.initState();
    buttonText = 'Sq ' + this.information;
    sqScore = double.parse(information);
  }

  bool plusClicked = false;
  bool minusClicked = false;

  @override
  Widget build(BuildContext context) {
    double sqVal;

    void _changeSqValue() {
      if (plusClicked) {
        sqVal = double.parse(information) + 0.5;
      } else if (minusClicked) {
        sqVal = double.parse(information) - 0.5;
      } else {
        sqVal = double.parse(information);
      }
      sqScore = sqVal;
      buttonText = 'Sq ' + sqVal.toString();
    }

    _changeColorMinus() {
      setState(() {
        minusClicked = !minusClicked;
        if (plusClicked) {
          plusClicked = !plusClicked;
        }
        _changeSqValue();
      });
    }

    _changeColorPlus() {
      setState(() {
        plusClicked = !plusClicked;
        if (minusClicked) {
          minusClicked = !minusClicked;
        }
        _changeSqValue();
      });
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 200, height: 200),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                primary: _getSqColor(getSqScore()),
                onPrimary: Colors.white, // foreground
              ),
              child: Text(
                buttonText,
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              onPressed: () {},
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 8.0)),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Click for Intermediate Value:',
                style: TextStyle(fontSize: 20),
              )
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 130,
                  height: 60,
                  child: TextButton(
                    onPressed: () {
                      if (!(double.parse(information) <= 1)) {
                        _changeColorMinus();
                      }
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: _getIntermediateValueButtonColorMinus(
                            information, minusClicked),
                        textStyle: TextStyle(
                            fontSize: 24, fontStyle: FontStyle.italic)),
                    child: Text('- 0.5'),
                  ),
                ),
                SizedBox(
                  width: 130,
                  height: 60,
                  child: TextButton(
                    onPressed: () {
                      if (!(double.parse(information) >= 4)) {
                        _changeColorPlus();
                      }
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor:
                        _getIntermediateValueButtonColorPlus(
                            information, plusClicked),
                        textStyle: TextStyle(
                            fontSize: 24, fontStyle: FontStyle.italic)),
                    child: Text('+ 0.5'),
                  ),
                ),
              ])
        ]);
  }
}

MaterialColor _getSqColor(double sqVal) {
  if (sqVal < 1.5) {
    return Colors.green;
  }
  else if (sqVal >= 1.5 && sqVal <= 2.0) {
    return Colors.lightGreen;
  }
  else if (sqVal > 2.0 && sqVal <= 3.0) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

MaterialColor _getIntermediateValueButtonColorPlus(String information,
    bool minusClicked) {
  if (double.parse(information) >= 4) {
    return Colors.grey;
  } else {
    return minusClicked ? _getSqColor(getSqScore()) : Colors.blue;
  }
}

MaterialColor _getIntermediateValueButtonColorMinus(String information,
    bool minusClicked) {
  if (double.parse(information) <= 1) {
    return Colors.grey;
  } else {
    return minusClicked ? _getSqColor(getSqScore()) : Colors.blue;
  }
}

/*
  Sq Page Submit Button Panel.
 */

class ButtonPanelSqSubmit extends StatelessWidget {
  final LinkdList linkedList;

  ButtonPanelSqSubmit(this.linkedList);

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
              linkedList.removeLastLinkElement();
              Navigator.of(context).pop();
              if (linkedList.isEmpty()) {
                Navigator.of(context).pop();
                Navigator.of(context).push(Routes.createRoutingPage(MyApp()));
              } else {
                Navigator.of(context)
                    .push(Routes.createRoutingPage(AssessmentPage(linkedList)));
              }
            },
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
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(Routes.createRoutingPage(RmScorePage()));
              },
            ),
          ),
          redoIconButtonWidget(context),
        ]);
  }
}
