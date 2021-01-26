import 'dart:ui';

import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  final String noteTitle;
  final String noteContent;

  Note({Key key, this.noteTitle, this.noteContent});

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        color: Colors.orangeAccent,
        child: Column(
          children: <Widget>[
            Text(
              widget.noteTitle,
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              indent: 5,
              endIndent: 10,
            ),
            Column(
              children: [
                Text(
                  widget.noteContent,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black45,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
