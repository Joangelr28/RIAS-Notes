import 'package:hive/hive.dart';
import 'package:notes_app/src/models/quick_note.dart';

class QuickNoteDB {
  // Box name
  String _boxName = 'quickNotes';

  // Quick Notes List
  List<QuickNote> _quickNotes = [];

  // Get Quick Notes List
  void getNotes() async {
    var box = await Hive.openBox<QuickNote>(_boxName);
    _quickNotes = box.values.toList();
  }

  // Create Quick Note
  void addNote(QuickNote newQuickNote) async {
    var box = await Hive.openBox<QuickNote>(_boxName);
    await box.add(newQuickNote);
  }

  // Read Quick Note
  QuickNote getNote(index) {
    return _quickNotes[index];
  }

  // Edit Quick Note
  void editNote(QuickNote quickNote, int index) async {
    var box = await Hive.openBox<QuickNote>(_boxName);
    await box.put(index, quickNote);
  }

  // Delete Quick Note
  void deleteNote(int index) async {
    var box = await Hive.openBox<QuickNote>(_boxName);
    await box.deleteAt(index);
  }
}
