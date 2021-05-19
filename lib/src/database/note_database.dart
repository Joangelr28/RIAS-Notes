import 'package:hive/hive.dart';
import 'package:notes_app/src/models/note.dart';

class NoteDB {
  // Box name
  String _boxName = 'notes';

  // Notes list
  List<Note> notes = [];

  // Get Notes List
  void getNotes() async {
    var box = await Hive.openBox<Note>(_boxName);
    notes = box.values.toList();
  }

  // Create Note
  void addNote(Note newNote) async {
    var box = await Hive.openBox<Note>(_boxName);
    await box.add(newNote);
  }

  // Read Note
  Note getNote(index) {
    getNotes();
    return notes[index];
  }

  // Update Note
  void editNote(Note note, int noteKey) async {
    var box = await Hive.openBox<Note>(_boxName);
    await box.put(noteKey, note);
  }

  // Delete Note
  void deleteNote(int index) async {
    var box = await Hive.openBox<Note>(_boxName);
    await box.deleteAt(index);
  }
}
