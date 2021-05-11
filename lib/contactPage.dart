import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/universalWidgets.dart';
import 'package:flutter_app/urlLauncher.dart';

///
/// Class: DisplayContactInformation
///
/// Displays GrassLand Agro Contact Information (phone, email, maps).
///
/// Return: [Widget] of the contact page.
///
class DisplayContactInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget('Grassland Agro Contact'),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              //Spacer(),
              /// Phone icon button.
              // IconButton(
              //   //icon: Icon(Icons.phone),
              //   icon: new Icon(Icons.phone, size: 50.0),
              //   tooltip: 'Phone Call',
              //   onPressed: () {
              //     launchPhoneURL(context);
              //   },
              // ),
              // Padding(padding: EdgeInsets.only(bottom: 8.0)),
              // Text('(+353) 86 846 6734'),
              Spacer(),
              /// Email icon button.
              IconButton(
                //icon: Icon(Icons.email),
                icon: new Icon(Icons.email, size: 50.0),
                tooltip: 'Email',
                onPressed: () {
                  launchMailURL('grassland.info.temp@gmail.com', 'GrassVESS App Query',
                      'Your Query ...', context);
                },
              ),
              Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text('grassland.info.temp@gmail.com'),
              Spacer(),
              /// Map icon buttons (x4).
              _mapIcon(52.6528337, -8.6584745, context),
              Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text('Grassland Agro Limerick'),
              Spacer(),
              _mapIcon(51.8936195, -8.5324602, context),
              Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text('Grassland Agro Cork'),
              Spacer(),
              _mapIcon(53.3116337, -6.3612252, context),
              Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text('Grassland Agro Dublin'),
              Spacer(),
              _mapIcon(53.7152505, -6.5318012, context),
              Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text('Grassland Agro Meath'),
              Spacer(),
            ])));
  }
}

///
/// Method: _mapIcon
///
/// Displays Maps icon for each Grassland Agro Office.
///
/// Input:
///   [double] xVal is the maps x-coordinate.
///   [double] yVal is the maps y-coordinate.
///   [BuildContext] handle for the current widget.
/// Return: [IconButton] of the map icon.
///
IconButton _mapIcon(double xVal, double yVal, BuildContext context) {
  return IconButton(
    //icon: Icon(Icons.email),
    icon: new Icon(Icons.map, size: 50.0),
    tooltip: 'Maps',
    onPressed: () {
      launchMapURL(xVal, yVal, context);
    },
  );
}