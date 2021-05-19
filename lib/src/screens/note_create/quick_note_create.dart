import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/src/database/quick_notes_database.dart';
import 'package:notes_app/src/models/quick_note.dart';

class QuickNoteCreateScreen extends StatefulWidget {
  final QuickNote quickNoteInEditing;
  final int index;

  QuickNoteCreateScreen(this.index, this.quickNoteInEditing);

  @override
  _QuickNoteCreateScreenState createState() => _QuickNoteCreateScreenState();
}

class _QuickNoteCreateScreenState extends State<QuickNoteCreateScreen> {
  FocusNode _focusNode = FocusNode();
  QuillController? _controller;
  Box<QuickNote> quickNoteBox = Hive.box('quickNotes');
  QuickNoteDB _quickNoteDB = QuickNoteDB();

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
        document: Document.fromJson(widget.quickNoteInEditing.content!),
        selection: const TextSelection.collapsed(offset: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('NoteEditing'),
        actions: [
          _buttonDelete(context),
          _buttonSave(context),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _editor(),
            _toolBar(),
          ],
        ),
      ),
    );
  }

  Widget _buttonSave(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _quickNoteDB.editNote(
            QuickNote(
              content: _controller!.document.toDelta().toJson(),
            ),
            widget.index);
        Navigator.pop(context);
      },
      child: Icon(Icons.check),
    );
  }

  Widget _buttonDelete(BuildContext context) {
    return ElevatedButton(
      onPressed: _confirmationDialog,
      child: Icon(Icons.close),
    );
  }

  Widget _editor() {
    return Expanded(
      child: QuillEditor(
        scrollController: ScrollController(),
        padding: EdgeInsets.zero,
        expands: false,
        scrollable: true,
        focusNode: _focusNode,
        autoFocus: false,
        controller: _controller!,
        readOnly: false, // change to true to be view only mode
      ),
    );
  }

  Widget _toolBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: QuillToolbar.basic(
        showQuote: false,
        showIndent: false,
        showHorizontalRule: false,
        showClearFormat: false,
        showColorButton: false,
        showBackgroundColorButton: false,
        showCodeBlock: false,
        showLink: false,
        showHistory: false,
        toolbarIconSize: 26,
        controller: _controller!,
      ),
    );
  }

  void _confirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 25, 30, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Desea Eliminar la Nota?',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _quickNoteDB.deleteNote(widget.index);
                        Navigator.pop(context);
                      },
                      child: Text('Si'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('No'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
