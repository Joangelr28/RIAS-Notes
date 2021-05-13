import 'dart:convert';
import 'dart:io';

class DataRepository {
  // Future<String> get _localPath async {
  // Directory directory = await getApplicationDocumentsDirectory();
  // return directory.path;
  // }

  Future<File> get _localFile async {
    // final path = _localPath;
    return File('/data/user/0/com.wcapps.riaservices/app_flutter/data.json');
  }

  Future<Map<String, dynamic>> readJson() async {
    try {
      final file = await _localFile;

      //Read he file
      Map<String, dynamic> data = jsonDecode(file.readAsStringSync());
      return data;
    } catch (e) {
      print(e);
      return {'no': "Sirvio"};
    }
  }

  Future<File> writeJson(Map<String, dynamic>? json) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(json));
  }
}
