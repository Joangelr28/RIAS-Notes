import 'dart:convert';

import 'package:flutter/services.dart';

class UserRepository {
  List? userData, noteData;
//Login
//GetProps

// Get UserData
  Future<List> getUserData() async {
    var _jsonData = await rootBundle.loadString('assets/data/data.json');
    Map<String, dynamic> json = jsonDecode(_jsonData);
    userData = json['user'];
    return userData!;
  }

  //Register
  Future<void>? signUp(email, username, password) {
    return null;
  }
}
