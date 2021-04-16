
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/rmPage.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/previouslySavedAssessments.dart';
import 'package:flutter_app/sqPage.dart';
import 'package:flutter_app/tree.dart';
import 'package:flutter_app/universalWidgets.dart';

import 'aboutPage.dart';
import 'assessmentPage.dart';
import 'assessmentSummaryPage.dart';
import 'contactPage.dart';

///
/// Class: HomePage
///
/// Displays application home page consisting of side menu and start assessment button.
///
/// Return: [Widget] of the home page.
///
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: appBarWidget('GrassVESS Assessment', implyLeading: true),
        body: Center(
            child: StartAssessmentButton()
        ));
  }
}

///
/// Class: StartAssessmentButton
///
/// Ensures the start assessment button widget is populated as a stateful widget.
///
class StartAssessmentButton extends StatefulWidget {
  createState() => StartAssessmentButtonWidget();
}


///
/// Class: StartAssessmentButtonWidget
///
/// Displays the start assessment button.
///
/// Return: [Widget] of the start assessment button.
///
class StartAssessmentButtonWidget extends State {

  /// Create linked list to store assessment information.
  LinkdList linkedList = new LinkdList();
  String buttonText = 'Start Assessment';

  @override
  Widget build(BuildContext context) {

    /// Reset sq score, rm score and description fields.
    setDescriptionField();
    setSqScore();
    setRmScore();

    /// Method to change the text of the assessment
    /// button once the assessment has started.
    void _changeText() {
      setState(() {
        buttonText = 'Resume Assessment';
      });
    }

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 200, height: 200),

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: PrimaryColor,
          shape: CircleBorder(),
        ),
        onPressed: () {
          print(buttonText);
          if (buttonText == 'Start Assessment') {
            linkedList.initialiseLinkedList();
            _changeText();
          }
          /// if still in flow chart stage.
          if (getSqScore() > 0.0 && getRmScore() > 0.0) {
            Navigator.of(context).push(
                Routes.createRoutingPage(MainAssessmentSummaryPage(getRmScore())));
          }
          /// else, if in sq score state.
          else if (linkedList
              .getPreviousElement()
              .getLinkName()
              .contains('link4_')) {
            Navigator.of(context)
                .push(Routes.createRoutingPage(SqScorePage(linkedList)));
          }
          /// else, in assessment summary stage.
          else {
            Navigator.of(context)
                .push(Routes.createRoutingPage(AssessmentPage(linkedList)));
          }
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

///
/// Class: SideMenu
///
/// Displays the side menu.
///
/// Return: [Widget] of the side menu.
///
class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('images/grassland_logo_transparent_new.png')
                )),
          ),
          ListTile(
            leading: Icon(Icons.perm_device_information,
                color: PrimaryColor),
            title: Text('About'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(Routes.createRoutingPage(AboutPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.note,
                color: PrimaryColor),
            title: Text('Saved Assessments'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(Routes.createRoutingPage(DisplaySavedAssessments()));
            },
          ),
          ListTile(
            leading: Icon(Icons.quick_contacts_dialer,
                color: PrimaryColor),
            title: Text('Contact'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(Routes.createRoutingPage(DisplayContactInformation()));
            },
          ),
        ],
      ),
    );
  }
}