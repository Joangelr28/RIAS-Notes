import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/src/models/quick_note.dart';
import 'package:notes_app/src/screens/notes/notes_screen.dart';
import 'package:notes_app/src/screens/quick_notes/quick_note_tile.dart';

class QuickNotesGrid extends StatefulWidget {
  @override
  _QuickNotesGridState createState() => _QuickNotesGridState();
}

class _QuickNotesGridState extends State<QuickNotesGrid> {
  viewType? notesViewType;
  final Box<QuickNote> quickNoteBox = Hive.box('quickNotes');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _stgKey = GlobalKey();
    return Container(
      child: Padding(
        padding: _paddingForView(context),
        child: StaggeredGridView.count(
          key: _stgKey,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          crossAxisCount: 1,
          children: List.generate(quickNoteBox.length, (i) {
            return _tileGenerator(i);
          }),
          staggeredTiles: _tilesForView(),
        ),
      ),
    );
  }

  List<StaggeredTile> _tilesForView() {
    // Generate staggered tiles for the view based on the current preference.
    return List.generate(quickNoteBox.length, (index) {
      return StaggeredTile.fit(1);
    });
  }

  EdgeInsets _paddingForView(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double padding;
    double topBottom = 8;
    if (width > 500) {
      padding = (width) * 0.05; // 5% padding of width on both side
    } else {
      padding = 8;
    }
    return EdgeInsets.only(
        left: padding, right: padding, top: topBottom, bottom: topBottom);
  }

  QuickNoteTile _tileGenerator(int i) {
    return QuickNoteTile(
      i,
      QuickNote(
        content: quickNoteBox.getAt(i)!.content,
      ),
    );
  }
}
