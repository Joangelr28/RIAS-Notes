import 'package:flutter/material.dart';

class NoteCreateScreen extends StatefulWidget {
  NoteCreateScreen({Key key}) : super(key: key);

  @override
  _NoteCreateScreenState createState() => _NoteCreateScreenState();
}

class _NoteCreateScreenState extends State<NoteCreateScreen> {
  TextEditingController _titleController, _contentController;

  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creacion de Notas'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: null,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blueAccent)),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    border: InputBorder.none, labelText: 'Titulo de la Nota'),
                onSubmitted: (String value) async {
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Thanks!'),
                        content: Text('You typed "$value".'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const Divider(
              color: Colors.black12,
              height: 20,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.orangeAccent)),
                  child: TextField(
                    controller: _contentController,
                    maxLines: 35,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(fontSize: 30),
                        labelText: 'Contenido de la Nota'),
                    onSubmitted: (String value) async {
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Thanks!'),
                            content: Text('You typed "$value".'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
