import 'package:flutter/material.dart';
import 'package:notes_app/src/screens/home/home_screen.dart';
import '../register/register_screen.dart';
import '../../assets/global_methods.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey _loginKey = GlobalKey<FormState>();

  final _userController = TextEditingController();
  final _passwoerdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginKey,
      child: Column(
        children: [
          TextFormField(
            controller: _userController,
            decoration: InputDecoration(
              labelText: 'Username or Email',
            ),
            onSaved: null,
          ),
          TextFormField(
            controller: _passwoerdController,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            onSaved: null,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color?>(Colors.red[700]),
            ),
            onPressed: () => pushScreen(context, HomeScreen()),
            child: Text('Sign in'),
          ),
          TextButton(
            child: Text('Sign up'),
            onPressed: () => pushScreen(context, RegisterScreen()),
          ),
        ],
      ),
    );
  }
}
