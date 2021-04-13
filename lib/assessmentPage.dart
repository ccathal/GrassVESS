import 'package:flutter/material.dart';
import 'package:flutter_app/sqPage.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/parseJsonFile.dart';
import 'package:flutter_app/tree.dart';
import 'package:flutter_app/universalWidgets.dart';
import 'main.dart';

/*
  Main Assessment Page
 */

class AssessmentPage extends StatelessWidget {
  final LinkdList linkedList;

  AssessmentPage(this.linkedList);

  Widget futureProfileCardDraggableWidget() {
    _checkLinkConditions(linkedList.getPreviousElement());
    return new FutureBuilder<List>(
      future: readJsonCard(linkedList.getPreviousElement().getLinkName()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ProfileCardDraggable(snapshot.data[0], snapshot.data[1]);
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topCenter,
                      child: futureInstructionBoxWidget(linkedList.getPreviousElement().getLinkName())),
                  Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: futureProfileCardDraggableWidget())),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: ButtonPanel(linkedList),
                      ))
                ])));
  }

  void _checkLinkConditions(Link link) {
    if (link.id == "link1_2" || link.id == 'link2_3' || link.id == 'link2_1') {
      setLinkCondition2_2(link);
    }
    if (link.id == 'link2_5' || link.id == 'link3_4' || link.id == 'link3_2') {
      setLinkCondition3_3(link);
    }
  }
}

Widget futureInstructionBoxWidget(linkName) {
  return new FutureBuilder<String>(
    future:
    readJsonInstruction(linkName),
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

/*
  Instruction TextBox
 */

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

  BoxDecoration _myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.blue, width: 2.0),
      borderRadius:
      BorderRadius.all(Radius.circular(5.0) //         <--- border radius here
      ),
    );
  }
}

/*
  Profile Card Widget
 */

class ProfileCardDraggable extends StatelessWidget {
  final String information;
  final String picture;

  ProfileCardDraggable(this.information, this.picture);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double yourDimension = width * 0.9;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Image.asset('images/' + picture,
                width: yourDimension, height: yourDimension, fit: BoxFit.fill),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(information,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.start),
                ],
              ))
        ],
      ),
    );
  }
}

/*
  Button Panel
 */

class ButtonPanel extends StatelessWidget {
  final LinkdList linkedList;

  ButtonPanel(this.linkedList);

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
          if (!(linkedList.getPreviousElement().right.getLinkName() ==
              'null_link'))
            SizedBox(
              width: 130,
              height: 60,
              child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor:
                      _getYesColor(linkedList.getPreviousElement()),
                      textStyle:
                      TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
                  child: Text('Yes'),
                  onPressed: () {
                    Link addLink = linkedList.getPreviousElement().right;
                    _nextAssessmentRoute(addLink, linkedList, context);
                  }),
            ),
          if (!(linkedList.getPreviousElement().left.getLinkName() ==
              'null_link'))
            SizedBox(
              width: 130,
              height: 60,
              child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor:
                      _getNoColor(linkedList.getPreviousElement()),
                      textStyle:
                      TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
                  child: Text('No'),
                  onPressed: () {
                    Link addLink = linkedList.getPreviousElement().left;
                    _nextAssessmentRoute(addLink, linkedList, context);
                  }),
            ),
          redoIconButtonWidget(context),
        ]);
  }

  Color _getYesColor(Link link) {
    if (link.right.getLinkName() != 'null_link') {
      return Colors.green;
    } else {
      return Colors.blueGrey;
    }
  }

  Color _getNoColor(Link link) {
    if (link.left.getLinkName() != 'null_link') {
      return Colors.red;
    } else {
      return Colors.blueGrey;
    }
  }

  _nextAssessmentRoute(addLink, linkedList, context) {
    linkedList.addLinkElement(addLink);
    Navigator.of(context).pop();
    if (linkedList.getPreviousElement().getLinkName().contains('link4_')) {
      Navigator.of(context)
          .push(Routes.createRoutingPage(SqScorePage(linkedList)));
    } else {
      Navigator.of(context)
          .push(Routes.createRoutingPage(AssessmentPage(linkedList)));
    }
  }
}
