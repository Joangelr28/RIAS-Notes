import 'package:hive/hive.dart';
import 'package:notes_app/src/models/note.dart';

class NoteDB {
  // Nombre del Box
  String _boxName = 'notes';

  // Lista de Notas
  List<Note> _notes = [];

  Note getNote(index) {
    return _notes[index];
  }

  void getNotes() async {
    var box = await Hive.openBox<Note>(_boxName);
    _notes = box.values.toList();
  }

  void addNote(Note newNote) async {
    var box = await Hive.openBox<Note>(_boxName);

    await box.add(newNote);
  }

  void editNote(Note note, int noteKey) async {
    var box = await Hive.openBox<Note>(_boxName);
    await box.put(noteKey, note);
  }
}
