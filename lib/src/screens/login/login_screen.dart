import 'package:flutter/material.dart';
import 'package:notes_app/src/repository/data_repository.dart';
import './login_form.dart';

class LoginScreen extends StatefulWidget {
  final DataRepository data = DataRepository();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
            height: 300,
            width: 300,
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: LoginForm()),
      ),
    );
  }
}
