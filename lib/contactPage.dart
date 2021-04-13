import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/urlLauncher.dart';

class DisplayContactInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Previous GrassVESS Assessments'),
            automaticallyImplyLeading: false),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Spacer(),
              IconButton(
                //icon: Icon(Icons.phone),
                icon: new Icon(Icons.phone, size: 50.0),
                tooltip: 'Phone Call',
                onPressed: () {
                  launchPhoneURL(context);
                },
              ),
              Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text('(+353) 86 846 6734'),
              Spacer(),
              IconButton(
                //icon: Icon(Icons.email),
                icon: new Icon(Icons.email, size: 50.0),
                tooltip: 'Email',
                onPressed: () {
                  launchMailURL('cathalcorbett3@gmail.com', 'GrassVESS App Query',
                      'ToDo', context);
                },
              ),
              Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text('cathalcorbett3@gmail.com'),
              Spacer(),
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

_mapIcon(double x_val, double y_val, BuildContext context) {
  return IconButton(
    //icon: Icon(Icons.email),
    icon: new Icon(Icons.map, size: 50.0),
    tooltip: 'Maps',
    onPressed: () {
      launchMapURL(x_val, y_val, context);
    },
  );
}