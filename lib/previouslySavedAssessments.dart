import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/parseAssessmentsFile.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/universalWidgets.dart';
import 'package:flutter_app/urlLauncher.dart';

/// Iterator for numbering the assessments.
int iterator = 0;

///
/// Class: DisplaySavedAssessments
///
/// Page to display previous assessments contained in storage.
///
/// Return: [Widget] of the previous assessments page.
///
class DisplaySavedAssessments extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Previous GrassVESS Assessments'),
      body: FutureBuilder<dynamic>(
        future: amendCsvAssessmentFile(),
        builder: (context, snapshot) {
          /// if storage data exists.
          if (snapshot.hasData) {
            List<String> returnStr = snapshot.data;
            /// if data is empty.
            if (returnStr.isEmpty) {
              return _emptyAssessmentsWidget(context);
            }
            /// if data exists.
            else {
              return _populateAssessmentsListWidget(returnStr, context);
            }
          }
          /// else if error has occurred retrieving data.
          else if (snapshot.hasError) {
            return _emptyAssessmentsWidget(context);
          }
          return new Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ///
  /// Widget to display when no assessments have been saved to storage.
  ///
  Center _emptyAssessmentsWidget(BuildContext context) {
    return Center(
        child: EmptyListWidget(
            title: 'No Available Assessments',
            subTitle: 'Create GrassVESS Assessment',
            image: 'images/grassland_logo_transparent_new.png',
            titleTextStyle: Theme.of(context)
                .typography
                .dense
                .headline4
                .copyWith(color: Color(0xff9da9c7)),
            subtitleTextStyle: Theme.of(context)
                .typography
                .dense
                .bodyText1
                .copyWith(color: Color(0xffabb8d6))));
  }

  ///
  /// Widget to populate a scroll page of the saved storage assessments.
  ///
  SingleChildScrollView _populateAssessmentsListWidget(List<String> list, BuildContext context) {
    iterator = 0;
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                for (var item in list) _savedAssessmentsList(item, context)
              ]),
        ));
  }

  ///
  /// Widget to display table with information of a single assessment.
  ///
  Column _savedAssessmentsList(String v, BuildContext context) {
    List<String> splitted = v.split(',');
    iterator++;
    int entryValue = iterator;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                    'Assessment ' + iterator.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  )),
              IconButton(
                  icon: Icon(Icons.cancel),
                  iconSize: 26.0,
                  tooltip: 'Remove Assessment',
                  onPressed: () async {
                    final ConfirmAction action =
                    await asyncConfirmDialog('Delete Assessment', context);

                    if (action == ConfirmAction.Accept) {
                      await amendCsvAssessmentFile(deleteEntryIndex: entryValue);
                      Future.delayed(Duration.zero, () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                            Routes.createRoutingPage(DisplaySavedAssessments()));
                      });
                    }
                  }),
              IconButton(
                icon: Icon(Icons.email),
                iconSize: 26.0,
                tooltip: 'Email Assessment',
                onPressed: () {
                  String emailBody =
                      'Sq Score: ${splitted[0]}\nRm Score: ${splitted[1]}\nDateTime: ${splitted[2]}\nGPS (long, lat): ${splitted[3]}\nDescription: ${splitted[4]}';
                  launchMailURL('cathalcorbett3@gmail.com',
                      'GrassVESS Assessment Submission', emailBody, context);
                },
              ),
            ],
          )),
          DataTable(
            headingRowHeight: 0,
            columns: [
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Date & Time')),
                DataCell(Text(splitted[2])),
              ]),
              DataRow(cells: [
                DataCell(Text('Sq Score')),
                DataCell(Text(splitted[0])),
              ]),
              DataRow(cells: [
                DataCell(Text('Rm Score')),
                DataCell(Text(splitted[1])),
              ]),
              DataRow(cells: [
                DataCell(Text('GPS Location')),
                DataCell(Text(splitted[3])),
              ]),
              DataRow(cells: [
                DataCell(Text('Description')),
                DataCell(Text(splitted[4])),
              ]),
            ],
          ),
          Divider(
            color: Colors.black,
            height: 20,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
        ]);
  }
}
