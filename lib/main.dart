import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/src/models/note.dart';
import 'package:notes_app/src/models/quick_note.dart';
import 'package:notes_app/src/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialice Hive on App startup
  await Hive.initFlutter();

  // Register adapters (if any)
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(QuickNoteAdapter());

  // Open Hive boxe for use throughout the app
  await Hive.openBox<Note>('notes');
  await Hive.openBox<QuickNote>('quickNotes');

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
      home: HomeScreen(),
    );
  }
}
