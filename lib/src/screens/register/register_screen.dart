import 'package:flutter/material.dart';
import 'package:notes_app/src/screens/register/register_form.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Container(
            height: 500,
            width: 300,
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red[700]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: RegisterForm()),
      ),
    );
  }
}
