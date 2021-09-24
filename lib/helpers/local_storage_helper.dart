import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pp;

class LocalStorageHelper {
  static Future<void> saveToFile(String filename, String data) async {
    final combinedPath = await _getFilePath(filename);
    final file = File(combinedPath);
    await file.writeAsString(data);
  }

  static Future<String> readFile(String filename) async {
    final combinedPath = await _getFilePath(filename);
    final data = await File(combinedPath).readAsString();
    return data;
  }

  static Future<String> _getFilePath(String filename) async {
    final docDir = await pp.getApplicationDocumentsDirectory();
    return path.join(docDir.path, filename);
  }
}
