import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:notes_app/src/models/models.dart';
import 'package:notes_app/src/screens/note_create/note_create_screen.dart';
import 'package:notes_app/src/screens/utility.dart';

class NoteTile extends StatefulWidget {
  final Note note;
  NoteTile(this.note);
  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  String? title;
  String? _content;
  Color? tileColor;

  @override
  Widget build(BuildContext context) {
    title = widget.note.title!;
    _content = Document.fromJson(widget.note.content!).toPlainText();
    // tileColor = widget.note.color!;

    return GestureDetector(
      onLongPress: () => _noteTapped(context),
      onTap: () => _noteTapped(context),
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

  void _noteTapped(BuildContext ctx) {
    CentralStation.updateNeeded = false;
    Navigator.push(ctx,
        MaterialPageRoute(builder: (ctx) => NoteCreateScreen(widget.note)));
  }

  Widget constructChild() {
    List<Widget> contentsOfTiles = [];

    if (widget.note.title!.length != 0) {
      contentsOfTiles.add(
        AutoSizeText(
          title!,
          style: TextStyle(fontWeight: FontWeight.bold),
          maxLines: widget.note.title!.length == 0 ? 1 : 3,
          textScaleFactor: 1.5,
        ),
      );

      contentsOfTiles.add(
        Divider(
          color: Colors.transparent,
          height: 5,
        ),
      );
    }

    contentsOfTiles.add(
      AutoSizeText(
        _content!,
        maxLines: 8,
        textScaleFactor: 1.2,
      ),
    );

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: contentsOfTiles);
  }
}
