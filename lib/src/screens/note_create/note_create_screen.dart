import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/src/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class NoteCreateScreen extends StatefulWidget {
  final Note noteInEditing;

  NoteCreateScreen(this.noteInEditing);

  @override
  _NoteCreateScreenState createState() => _NoteCreateScreenState();
}

class _NoteCreateScreenState extends State<NoteCreateScreen> {
  FocusNode _focusNode = FocusNode();
  QuillController? _controller;
  Box<Note> noteBox = Hive.box('notes');
  TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
          _buttonSave(),
        ],
      ),
      body: Column(
        children: [
          _titleText(),
          _editor(),
          _toolBar(),
        ],
      ),
    );
  }

  Widget _buttonSave() {
    return ElevatedButton(
      onPressed: () {
        noteBox.add(Note(
            title: _titleController.value.text,
            content: _controller!.document.toDelta().toJson()));
        print(noteBox.length);
      },
      child: Icon(Icons.save),
    );
  }

  Widget _titleText() {
    return Container(
      child: TextField(
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
        toolbarIconSize: 20,
        controller: _controller!,
        onImagePickCallback: _onImagePickCallback,
      ),
    );
  }

  Future<String> _onImagePickCallback(File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }
}
