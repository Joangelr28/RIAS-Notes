import 'package:hive/hive.dart';
import 'package:notes_app/src/models/quick_note.dart';

class QuickNoteDB {
  // Nombre del Box
  String _boxName = 'quickNotes';

  // Lista de Notas
  List<QuickNote> _quickNotes = [];

  QuickNote getNote(index) {
    return _quickNotes[index];
  }

  void getNotes() async {
    var box = await Hive.openBox<QuickNote>(_boxName);
    _quickNotes = box.values.toList();
  }

  void addNote(QuickNote newQuickNote) async {
    var box = await Hive.openBox<QuickNote>(_boxName);

    await box.add(newQuickNote);
  }

  void editNote(QuickNote quickNote, int noteKey) async {
    var box = await Hive.openBox<QuickNote>(_boxName);
    await box.put(noteKey, quickNote);
  }
}
