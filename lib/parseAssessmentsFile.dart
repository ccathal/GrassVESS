import 'dart:async' show Future;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

///
/// Method: amendCsvAssessmentFile
///
/// Method to read, write, delete entries to assessments storage file.
///
/// Input:
///   [Integer] deleteEntryIndex optional argument is the
///     index of the line to delete in assessment storage file.
///   [String] writeString optional argument is a new assessment entry
///     to write to assessment storage file.
/// Return: [Future<dynamic>]. Depending on if -
///   reading (returns Future<List<String>> of file content lines split into a list)
///   writing (returns Future<File>)
///   deleting (returns Future<File>)
///
Future<dynamic> amendCsvAssessmentFile({int deleteEntryIndex, String writeString}) async {

  /// Retrieve "External Storage Directory" for Android and "NSApplicationSupportDirectory" for iOS
  Directory directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();

  /// Create a new file if not alredy created.
  File file = await File('${directory.path}/assessment_data.txt').create();

  /// Read the file content
  String fileContent = await file.readAsString();

  List<String> lines;
  LineSplitter ls = new LineSplitter();
  lines = ls.convert(fileContent);

  /// Delete assessment entry check.
  if(deleteEntryIndex != null) {
    lines.removeAt(deleteEntryIndex - 1);
    String writeEntry = lines.join('\n');
    return await file.writeAsString(writeEntry);
  }

  /// Check to write assessment entry to file.
  if(writeString != null) {
    return await file.writeAsString('$writeString$fileContent');
  }
  return lines;
}

///
/// Method: deleteFile
///
/// Method to delete assessments storage file.
/// This method should only ever be called for testing purposes.
///
/// Return: [Future<FileSystemEntity>] after file deletion.
///
Future<FileSystemEntity> deleteFile() async {
  /// Retrieve "External Storage Directory" for Android and "NSApplicationSupportDirectory" for iOS
  Directory directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();

  File file = await File("${directory.path}/assessment_data.txt").create();
  return await file.delete();
}