import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:async';

// Fetch content from the json file
Future<String> readJsonInformation(String linkString) async {
  String dataStr =  await rootBundle.loadString('link_data/data.json');
  Map data = json.decode(dataStr);
  Map link = data[linkString];
  String information = link['data'];
  return information;
}

// Fetch content from the json file
Future<String> readJsonInstruction(String linkString) async {
  String dataStr =  await rootBundle.loadString('link_data/data.json');
  Map data = json.decode(dataStr);
  Map link = data[linkString];
  String instruction = link['instruction'];
  return instruction;
}

// Fetch content from the json file
Future<String> readJsonPicture(String linkString) async {
  String dataStr =  await rootBundle.loadString('link_data/data.json');
  Map data = json.decode(dataStr);
  Map link = data[linkString];
  String picture = link['image'];
  return picture;
}

// Fetch content from the json file
Future<List> readJsonCard(String linkString) async {
  String dataStr =  await rootBundle.loadString('link_data/data.json');
  Map data = json.decode(dataStr);
  Map link = data[linkString];
  String picture = link['image'];
  String information = link['data'];
  return [information, picture];
}