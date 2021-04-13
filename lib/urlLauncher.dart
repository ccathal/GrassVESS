import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

launchMailURL(
    String toMailId, String subject, String body, BuildContext context) async {
  var url = 'mailto:$toMailId?subject=$subject&body=$body';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    final snackBar = SnackBar(
      content: Text('No Email Application Configured.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

launchPhoneURL(BuildContext context) async {
  const url = 'tel:0868466734';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    final snackBar = SnackBar(
      content: Text('No Phone Call Application Configured.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

launchMapURL(double latitude, double longitude, context) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    final snackBar = SnackBar(
      content: Text('No Maps Application Configured.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Future<bool> checkLaunchURL(String toMailId) async {
  var url = 'mailto:$toMailId?';
  return await canLaunch(url);
}