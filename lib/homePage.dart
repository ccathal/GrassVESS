
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/rmPage.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/saved_assessments.dart';
import 'package:flutter_app/sqPage.dart';
import 'package:flutter_app/tree.dart';

import 'assessmentPage.dart';
import 'assessmentSummaryPage.dart';
import 'contactPage.dart';

/*
  Home Page.
 */

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(title: Text('GrassVESS Assessment')),
        body: Center(
            child: StartAssessmentButton()
        ));
  }
}

/*
  Start Assessment Button Widget.
 */

class StartAssessmentButton extends StatefulWidget {
  StartAssessmentButtonWidget createState() => StartAssessmentButtonWidget();
}

class StartAssessmentButtonWidget extends State {
  LinkdList linkedList = new LinkdList();
  String buttonText = 'Start Assessment';

  @override
  Widget build(BuildContext context) {
    setRmScore();
    setSqScore();
    setDescriptionField();
    setGpsField();
    setDateTimeField();

    changeText() {
      setState(() {
        buttonText = 'Resume Assessment';
      });
    }

    print(buttonText);
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 200, height: 200),
      child: ElevatedButton(
        onPressed: () {
          print(buttonText);
          if (buttonText == 'Start Assessment') {
            linkedList.initialiseLinkedList();
            changeText();
          }
          if (getSqScore() > 0.0 && getRmScore() > 0.0) {
            Navigator.of(context).push(
                Routes.createRoutingPage(AssessmentSummaryPage(getRmScore())));
          } else if (linkedList
              .getPreviousElement()
              .getLinkName()
              .contains('link4_')) {
            Navigator.of(context)
                .push(Routes.createRoutingPage(SqScorePage(linkedList)));
          } else {
            Navigator.of(context)
                .push(Routes.createRoutingPage(AssessmentPage(linkedList)));
          }
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
        ),
      ),
    );
  }
}

/*
  Side Menu Widget.
 */

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
                    image: AssetImage('images/grassland_logo_transparent.png'))),
          ),
          ListTile(
            leading: Icon(Icons.perm_device_information),
            title: Text('About'),
            onTap: () {
              Navigator.of(context).pop();
              //Navigator.of(context).push(Routes.createRoutingPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Saved Assessments'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(Routes.createRoutingPage(DisplaySavedAssessments()));
            },
          ),
          ListTile(
            leading: Icon(Icons.quick_contacts_dialer),
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