import 'dart:convert'; // for jsonEncode, jsonDecode
import 'dart:io'; // for File operations
import 'package:path_provider/path_provider.dart';

class JsonSaver {

  JsonSaver(path){
    filePath = path;
  }

  JsonSaver._(this.filePath);
  late String filePath;

  Future<void> writeData(Map<String, dynamic> data) async {
    final file = File(filePath);
    await file.writeAsString(jsonEncode(data));
  }

  Future<Map<String, dynamic>?> readData() async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        String contents = await file.readAsString();
        return jsonDecode(contents) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Error reading data: $e');
      return null;
    }
  }

  Future<void> clearData() async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}