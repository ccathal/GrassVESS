import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:async';

///
/// Method: readJson
///
/// Method to read link JSON information.
///
/// Input:
///   [String] linkString is the link name to read data from.
///   [String] instruction on the type of data to read.
/// Return: [Future<dynamic>] string or list<string> data returned.
///
Future<dynamic> readJson(String linkString, String instruction) async {
  String dataStr =  await rootBundle.loadString('link_data/data.json');
  Map data = json.decode(dataStr);
  Map link = data[linkString];

  if(instruction == 'information') {
    return link['data'];
  }
  else if(instruction == 'instruction') {
    return link['instruction'];
  }
  else {
    return [link['image'], link['data']];
  }
}