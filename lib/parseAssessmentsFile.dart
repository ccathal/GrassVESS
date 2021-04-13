import 'dart:async' show Future;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/*
  Method to read, write, delete entries to assessments file.
 */

Future<dynamic> amendCsvAssessmentFile({int deleteEntryIndex = null, String writeString = null}) async {

  // Retrieve "External Storage Directory" for Android and "NSApplicationSupportDirectory" for iOS
  Directory directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();

  // Create a new file. You can create any kind of file like txt, doc , json etc.
  File file = await File('${directory.path}/assessment_data.txt').create();

  // Read the file content
  String fileContent = await file.readAsString();

  List<String> lines;
  LineSplitter ls = new LineSplitter();
  lines = ls.convert(fileContent);

  // Delete assessment entry check.
  if(deleteEntryIndex != null) {
    lines.removeAt(deleteEntryIndex - 1);
    String writeEntry = lines.join('\n');
    return await file.writeAsString(writeEntry);
  }

  // Check to write assessment entry to file.
  if(writeString != null) {
    return await file.writeAsString('$fileContent$writeString');
  }
  return lines;
}

/*
  Delete Assessments File Method: Only used for testing.
 */

deleteFile() async {
  // Retrieve "External Storage Directory" for Android and "NSApplicationSupportDirectory" for iOS
  Directory directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();

  // Create a new file. You can create any kind of file like txt, doc , json etc.
  File file = await File("${directory.path}/assessment_data.txt").create();
  return await file.delete();
}