import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/src/database/note_database.dart';
import 'package:notes_app/src/models/models.dart';

class NoteCreateScreen extends StatefulWidget {
  final Note noteInEditing;
  final int index;

  NoteCreateScreen(this.index, this.noteInEditing);

  @override
  _NoteCreateScreenState createState() => _NoteCreateScreenState();
}

class _NoteCreateScreenState extends State<NoteCreateScreen> {
  FocusNode _focusNode = FocusNode();
  QuillController? _controller;
  Box<Note> noteBox = Hive.box('notes');
  TextEditingController _titleController = TextEditingController();
  NoteDB _noteDB = NoteDB();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.noteInEditing.title!;
    _controller = QuillController(
        document: Document.fromJson(widget.noteInEditing.content!),
        selection: const TextSelection.collapsed(offset: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('NoteEditing'),
        actions: [
          _buttonSave(context),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _titleText(),
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
        _noteDB.editNote(
            Note(
              title: _titleController.value.text,
              content: _controller!.document.toDelta().toJson(),
            ),
            widget.index);
        Navigator.pop(context);
      },
      child: Icon(Icons.save),
    );
  }

  Widget _titleText() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'New Note',
        ),
        controller: _titleController,
      ),
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
        autoFocus: true,
        controller: _controller!,
        readOnly: false, // change to true to be view only mode
      ),
    );
  }

  Widget _toolBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: QuillToolbar.basic(
        toolbarIconSize: 24,
        controller: _controller!,
        // onImagePickCallback: _onImagePickCallback,
      ),
    );
  }

  // Metodo para seleccionar y colocar imagenes (Arreglar para que guarde en HIVE)
  // Future<String> _onImagePickCallback(File file) async {
  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   final copiedFile =
  //       await file.copy('${appDocDir.path}/${basename(file.path)}');
  //   return copiedFile.path.toString();
  // }
}
