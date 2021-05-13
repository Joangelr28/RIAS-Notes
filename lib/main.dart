import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/src/blocs/login/login_bloc.dart';
import 'package:notes_app/src/models/note.dart';
import 'package:notes_app/src/screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialice Hive on App startup
  await Hive.initFlutter();

  // Register adapters (if any)
  Hive.registerAdapter(NoteAdapter());

  // Open Hive boxe for use throughout the app
  await Hive.openBox<Note>('notes');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.box('notes').compact();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginScreen(),
      home: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: LoginScreen(),
      ),
    );
  }
}
