import 'package:flutter/material.dart';
import 'quick_notes_grid.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      right: true,
      left: true,
      child: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: QuickNotesGrid(),
    );
  }
}
