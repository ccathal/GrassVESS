import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/universalWidgets.dart';

///
/// Class: AboutPage
///
/// Displays information about Grassland Agro and the GrassVESS application.
///
/// Returns: [Widget] of the about page.
///
class AboutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget('Grassland Agro & GrassVESS'),
        body: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 20.0, bottom: 10),
              child: Image.asset('images/grassland_logo_transparent_new.png')),
          Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowGlow();
                    return;
                  },
                  child: SingleChildScrollView(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '\nGrassland Agro',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\nGrassland Agro are part of a global company, Groupe Roullier. They have four industrial fertilizer plants in Limerick, Cork, Slane and Wexford. The revolutionary Speciality fertiliser range, conventional commodity and soil conditioning products help maximise tailored solutions to every farm.\n',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text(
                              '\nGrassVESS',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\nUsing the GrassVESS tool farmers can easily score the structural quality of their soils and identify problems, such as compaction, which can lead to poor crop rooting, reduced yields, drainage problems and increased nutrient losses and emissions.  Structural quality (Sq) and Root-mat (Rm) scores indicate the impact of land management on soil structure at different soil depths. This can help in making management decisions. Low scores indicate that land management is not negatively impacting soil structure. High scores indicate that management is negatively impacting soil structure and changes in management may be necessary.\n',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ]))))
        ]));
  }
}
