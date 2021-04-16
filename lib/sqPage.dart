import 'package:flutter/material.dart';
import 'package:flutter_app/parseJsonFile.dart';
import 'package:flutter_app/tree.dart';
import 'package:flutter_app/universalWidgets.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/rmPage.dart';
import 'assessmentPage.dart';
import 'main.dart';

double sqScore = 0.0;

///
/// Returns the set sq score.
///
double getSqScore() {
  return sqScore;
}

///
/// Resets the sq score.
///
void setSqScore() {
  sqScore = 0.0;
}

///
/// Class: SqScorePage
///
/// Main sq score page displays an instruction box, sq score button, text and
/// 2 buttons to increment/decrement the sq score, and a button panel.
///
/// Input: [linkedList] of the links that have been previously appended.
/// Output: [Widget] of the sq score page.
///
class SqScorePage extends StatelessWidget {

  final LinkdList linkedList;
  SqScorePage(this.linkedList);

  /// Future to read the json data to populate the button panel.
  Widget futureScoreSqTextButton() {
    return new FutureBuilder<dynamic>(
      future:
      readJson(linkedList.getPreviousElement().getLinkName(), 'information'),
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
      appBar: appBarWidget('GrassVESS Assessment'),
      body: Center(
        child: new Stack(children: <Widget>[
          /// Instruction Box Widget.
          Positioned(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: futureInstructionBoxWidget(linkedList.getPreviousElement().getLinkName()))),
          /// Sq Score Text Button Widget.
          Positioned(
              child: Align(
                  alignment: Alignment.center,
                  child: futureScoreSqTextButton())),
          /// Sq Score Button Panel.
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

///
/// Class: DisplayButtonPanelSqScore & DisplayButtonPanelSqScoreWidget
///
/// Sq Page Main Button Stateful Panel consisting sq score display button,
/// intermediate value text, and intermediate value buttons.
///
/// Input:
///   [information] is the sq score as String.
///   [linkedList] of the links that have been previously appended.
/// Returns: [Widget] of the sq score page button panel.
///
class DisplayButtonPanelSqScore extends StatefulWidget {

  final LinkdList linkedList;
  final String information;
  DisplayButtonPanelSqScore(this.information, this.linkedList);

  DisplayButtonPanelSqScoreWidget createState() =>
      DisplayButtonPanelSqScoreWidget(information, linkedList);
}

class DisplayButtonPanelSqScoreWidget extends State {

  final String information;
  final LinkdList linkedList;
  DisplayButtonPanelSqScoreWidget(this.information, this.linkedList);

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

    ///
    /// Changes the value of the sq score and text displayed.
    ///
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

    ///
    /// Method to change the boolean values when intermediate button '-0.5' is clicked.
    /// Additionally, the function changes the sq score text.
    ///
    void _changeColorMinus() {
      setState(() {
        minusClicked = !minusClicked;
        if (plusClicked) {
          plusClicked = !plusClicked;
        }
        _changeSqValue();
      });
    }

    ///
    /// Method to change the boolean values when an intermediate button '+0.5' is clicked.
    /// Additionally, the function changes the sq score text.
    ///
    void _changeColorPlus() {
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

  ///
  /// Default colors for each sq score.
  ///
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

  ///
  /// Method to get the color for the intermediate value '+0.5' button.
  ///
  Color _getIntermediateValueButtonColorPlus(String information,
      bool minusClicked) {
    if (double.parse(information) >= 4) {
      return Colors.grey;
    } else {
      return minusClicked ? _getSqColor(getSqScore()) : PrimaryColor;
    }
  }

  ///
  /// Method to get the color for the intermediate value '-0.5' button.
  ///
  Color _getIntermediateValueButtonColorMinus(String information,
      bool minusClicked) {
    if (double.parse(information) <= 1) {
      return Colors.grey;
    } else {
      return minusClicked ? _getSqColor(getSqScore()) : PrimaryColor;
    }
  }

}

///
/// Class: ButtonPanelSqSubmit
///
/// Sq Page Submit Button Panel consisting of back/continue/redo buttons.
///
/// Input: [linkedList] of the links that have been previously appended.
/// Returns: [Widget] of the sq score page button panel.
///
class ButtonPanelSqSubmit extends StatelessWidget {

  final LinkdList linkedList;
  ButtonPanelSqSubmit(this.linkedList);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /// Go Back Button.
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
          /// Continue Button.
          SizedBox(
            width: 130,
            height: 60,
            child: TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: PrimaryColor,
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
          /// Redo Assessment Button.
          redoIconButtonWidget(context),
        ]);
  }
}
