import 'package:flutter/material.dart';
import 'package:flutter_app/universalWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// Method: launchMailURL
///
/// Launches configured Email application. If no application is configured a
/// SnackBar with error message is displayed.
///
/// Input:
///   [toMailId] string of receiver email address.
///   [subject] string of email subject.
///   [body] string of email body.
///   [BuildContext] handle for the current widget.
/// Return: [void].
///
void launchMailURL(
    String toMailId, String subject, String body, BuildContext context) async {
  var url = 'mailto:$toMailId?subject=$subject&body=$body';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(makeSnackBar('No Email Application Configured.'));
  }
}

///
/// Method: launchPhoneURL
///
/// Launches configured phone application. If no application is configured a
/// SnackBar with error message is displayed.
///
/// Input:
///   [BuildContext] handle for the current widget.
/// Return: [void].
///
void launchPhoneURL(BuildContext context) async {
  const url = 'tel:0868466734';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(makeSnackBar('No Phone Call Application Configured.'));
  }
}

///
/// Method: launchMapURL
///
/// Launches configured Maps application. If no application is configured a
/// SnackBar with error message is displayed.
///
/// Input:
///   [latitude] double of map x-coordinate.
///   [longitude] double of map y-coordinate.
///   [BuildContext] handle for the current widget.
/// Return: [void].
///
void launchMapURL(double latitude, double longitude, context) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(makeSnackBar('No Maps Application Configured.'));
  }
}

///
/// Method: checkLaunchMailURL
///
/// Checks if there is a mail application configured
///
/// Input:
///   [toMailId] string of receiver email address.
/// Return: [Future<bool>]. True, if application configured. Else, false.
///
Future<bool> checkLaunchMailURL(String toMailId) async {
  var url = 'mailto:$toMailId?';
  return await canLaunch(url);
}