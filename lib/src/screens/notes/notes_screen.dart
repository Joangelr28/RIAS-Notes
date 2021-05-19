import 'package:flutter/material.dart';
import 'notes_grid.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  viewType? notesViewType;

  @override
  void initState() {
    super.initState();
    notesViewType = viewType.Staggered;
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
      child: NotesGrid(
        notesViewType: notesViewType!,
      ),
    );
  }
}

enum viewType {
  List,
  Staggered,
}
