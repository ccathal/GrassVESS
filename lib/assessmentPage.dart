import 'package:flutter/material.dart';
import 'package:flutter_app/sqPage.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/parseJsonFile.dart';
import 'package:flutter_app/tree.dart';
import 'package:flutter_app/universalWidgets.dart';
import 'main.dart';

///
/// Class: AssessmentPage
///
/// This page shows a flow chart picture with an
/// instruction box and 'yes/no/back/redo' button panel.
///
/// Input: A class object [LinkdList].
/// Return: [Widget] of the assessment page.
///
class AssessmentPage extends StatefulWidget {
  final LinkdList linkedList;

  AssessmentPage(this.linkedList);

  AssessmentPageWidget createState() => AssessmentPageWidget(linkedList);
}

class AssessmentPageWidget extends State {
  final LinkdList linkedList;

  AssessmentPageWidget(this.linkedList);

  String progressPlaceHolder = '... %';

  @override
  Widget build(BuildContext context) {
    // if (!linkedList.isEmpty()) {
    //   Future<dynamic> progressStr = readJson(
    //       linkedList.getPreviousElement().getLinkName(), 'progress');
    //   if (progressStr != null) {
    //     progressStr.then((val) {
    //       if (val == null) {
    //         return;
    //       }
    //       setState(() {
    //         print(progressStr.toString());
    //         progressPlaceHolder = val.toString() + ' %';
    //       });
    //     });
    //   }
    // }

    return Scaffold(
        appBar: appBarWidget('GrassVESS Assessment'),
        //appBarWidgetProgress('GrassVESS Assessment', progressPlaceHolder),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              futureProgressIndicator(linkedList.getPreviousElement().getLinkName()),

              /// Instruction Box Widget.
              Align(
                  alignment: Alignment.topCenter,
                  child: futureInstructionBoxWidget(
                      linkedList.getPreviousElement().getLinkName())),

              /// Flow Chart Card Widget.
              Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: _futureFlowChartCardWidget())),

              /// Button Panel Widget.
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: BottomButtonPad),
                    child: ButtonPanel(linkedList),
                  ))
            ])));
  }

  ///
  /// Method: _futureFlowChartCardWidget
  ///
  /// Future to retrieve flow chart data from JSON file
  /// and populate the flow chart card.
  ///
  /// Return [Widget] of the flow chart card with populated information.
  ///
  Widget _futureFlowChartCardWidget() {
    /// checks flow chart link conditions for two link2_2 and link3_3.
    _checkLinkConditions(linkedList.getPreviousElement());
    return new FutureBuilder<dynamic>(
      future: readJson(linkedList.getPreviousElement().getLinkName(), 'card'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FlowChartCard(snapshot.data[1], snapshot.data[0]);
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

  ///
  /// Method: _checkLinkConditions
  ///
  /// Checks certain flow chart nodes so that link conditions of
  /// nodes 2_2 and 3_3 can be amended to have correct flow through the chart.
  ///
  /// Input: [Link] to check condition
  /// Return: [void]
  ///
  void _checkLinkConditions(Link link) {
    /// check if the links are any of the following to amended flow for link2_2
    if (link.id == "link1_2" || link.id == 'link2_3' || link.id == 'link2_1') {
      setLinkCondition2_2(link);
    }

    /// check if the links are any of the following to amended flow for link3_3
    if (link.id == 'link2_5' || link.id == 'link3_4' || link.id == 'link3_2') {
      setLinkCondition3_3(link);
    }
  }
}

///
/// Class: FlowChartCard
///
/// Displays an individual flow chart card.
/// This page shows a flow chart picture with an
/// instruction box and 'yes/no/back/redo' button panel.
///
/// Input:
///   String [information] is the flow chart card information.
///   String [picture] is the image for the card.
/// Return: [Widget] of the flow chart card with information and image.
///
class FlowChartCard extends StatelessWidget {
  final String information;
  final String picture;

  FlowChartCard(this.information, this.picture);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double yourDimension = width * 0.9;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /// Card Image displayed.
          Flexible(
            child: Image.asset('images/' + picture,
                width: yourDimension, height: yourDimension, fit: BoxFit.fill),
          ),

          /// Card Information displayed.
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

///
/// Class: ButtonPanel
///
/// Displays a button panel with 'back/yes/no/redo' buttons.
///
/// Input: A class object [LinkdList].
/// Return: [Widget] of the button panel.
///
class ButtonPanel extends StatelessWidget {
  final LinkdList linkedList;

  ButtonPanel(this.linkedList);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /// Back button.
          IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            tooltip: 'Go Back',
            onPressed: () {
              linkedList.removeLastLinkElement();
              Navigator.of(context).pop();
              if (linkedList.isEmpty()) {
                print('gete');
                Navigator.of(context).pop();
                print('gete1');
                Navigator.of(context).push(Routes.createRoutingPage(MyApp()));
                print('gete11');
              } else {
                print('gete222');
                Navigator.of(context)
                    .push(Routes.createRoutingPage(AssessmentPage(linkedList)));
              }
            },
          ),

          /// Yes Button.
          if (!(linkedList.getPreviousElement().right.getLinkName() ==
              'null_link'))

            /// if right link if not null, display button
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: SizedBox(
                      height: 60,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.green,
                              textStyle: TextStyle(
                                  fontSize: 24, fontStyle: FontStyle.italic)),
                          child: Text('Yes'),
                          onPressed: () {
                            /// Add right link to list.
                            Link addLink =
                                linkedList.getPreviousElement().right;
                            linkedList.addLinkElement(addLink);

                            /// Display next assessment page.
                            _nextAssessmentRoute(addLink, context);
                          }),
                    ))),

          /// No Button.
          if (!(linkedList.getPreviousElement().left.getLinkName() ==
              'null_link'))

            /// if left link if not null, display button.
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: SizedBox(
                      height: 60,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.red,
                              textStyle: TextStyle(
                                  fontSize: 24, fontStyle: FontStyle.italic)),
                          child: Text('No'),
                          onPressed: () {
                            /// Add left link to list.
                            Link addLink = linkedList.getPreviousElement().left;
                            linkedList.addLinkElement(addLink);

                            /// Display next assessment page.
                            _nextAssessmentRoute(addLink, context);
                          }),
                    ))),

          /// Redo Button.
          redoIconButtonWidget(context),
        ]);
  }

  ///
  /// Method: _nextAssessmentRoute
  ///
  /// Displays the next route of the assessment.
  /// Checks to see if the new link clicked on is another
  /// flow chart link or an Sq Score link (link4_*).
  ///
  /// Input:
  ///   [Link] of the next page depending on the button clicked.
  ///   [BuildContext] handle for the current widget.
  /// Return: [void]
  ///
  _nextAssessmentRoute(Link addLink, BuildContext context) {
    Navigator.of(context).pop();

    /// if the next link is an Sq Score.
    if (linkedList.getPreviousElement().getLinkName().contains('link4_')) {
      Navigator.of(context)
          .push(Routes.createRoutingPage(SqScorePage(linkedList)));
    }

    /// else, next link is another flow chart item.
    else {
      Navigator.of(context)
          .push(Routes.createRoutingPage(AssessmentPage(linkedList)));
    }
  }
}
