import 'dart:convert';

import 'package:flutter/services.dart';

class NoteRepository {
  List? noteData;
  Map<String, dynamic>? noteMap;
  NoteRepository();

// Get NoteData
  Future<List> getNoteData() async {
    String _jsonData = await rootBundle.loadString('assets/data/data.json');
    Map<String, dynamic> json = jsonDecode(_jsonData);
    noteData = json['notes'];
    return noteData!;
  }

// Get NoteMap
  Future<Map<String, dynamic>?> getNoteMap() async {
    String _jsonData = await rootBundle.loadString('assets/data/data.json');
    Map<String, dynamic> json = jsonDecode(_jsonData);
    return json;
  }
}
