import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/simple_viewer.dart';
import 'package:notes_app/src/models/quick_note.dart';
import 'package:notes_app/src/screens/note_create/quick_note_create.dart';
import 'package:notes_app/src/screens/utility.dart';

class QuickNoteTile extends StatefulWidget {
  final int index;
  final QuickNote quickNote;
  QuickNoteTile(this.index, this.quickNote);
  @override
  _QuickNoteTileState createState() => _QuickNoteTileState();
}

class _QuickNoteTileState extends State<QuickNoteTile> {
  // String? _content;
  Color? tileColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _noteTapped(widget.index, context),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: CentralStation.borderColor),
            color: tileColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: EdgeInsets.all(8),
        child: constructChild(),
      ),
    );
  }

  void _noteTapped(int i, BuildContext ctx) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (ctx) => QuickNoteCreateScreen(i, widget.quickNote)));
  }

  Widget constructChild() {
    List<Widget> contentsOfTiles = [];
    contentsOfTiles.add(
      Container(
          child: QuillSimpleViewer(
        controller: QuillController(
            document: Document.fromJson(widget.quickNote.content!),
            selection: TextSelection.collapsed(offset: 0)),
      )),
    );
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: contentsOfTiles);
  }
}
