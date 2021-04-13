import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/parseAssessmentsFile.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/universalWidgets.dart';
import 'package:flutter_app/urlLauncher.dart';

int iterator = 0;

class DisplaySavedAssessments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Previous GrassVESS Assessments'),
          automaticallyImplyLeading: false),
      body: FutureBuilder<dynamic>(
        future: amendCsvAssessmentFile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> returnStr = snapshot.data;
            if (returnStr.isEmpty) {
              return _emptyAssessmentsWidget(context);
            } else {
              return _populateAssessmentsListWidget(returnStr, context);
            }
          } else if (snapshot.hasError) {
            return _emptyAssessmentsWidget(context);
          }
          return new Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _emptyAssessmentsWidget(context) {
    return Center(
        child: EmptyListWidget(
            title: 'No Available Assessments',
            subTitle: 'Create GrassVESS Assessment',
            image: 'images/grassland_logo_transparent.png',
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

  _populateAssessmentsListWidget(list, context) {
    iterator = 0;
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            for (var item in list) savedAssessmentsList(item, context)
          ]),
    ));
  }
}

Column savedAssessmentsList(String v, BuildContext context) {
  List<String> splitted = v.split(',');
  iterator++;
  int entryValue = iterator;
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
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
        ),
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
