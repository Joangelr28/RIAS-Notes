import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/src/models/models.dart';
import 'package:notes_app/src/screens/notes/notes_tile.dart';
import 'package:notes_app/src/screens/notes/notes_screen.dart';

class NotesGrid extends StatefulWidget {
  final notesViewType;

  NotesGrid({this.notesViewType});

  @override
  _NotesGridState createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  viewType? notesViewType;
  final Box<Note> noteBox = Hive.box('notes');
  @override
  void initState() {
    super.initState();
    this.notesViewType = widget.notesViewType!;
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
          crossAxisCount: _colForStaggeredView(context),
          children: List.generate(noteBox.length, (i) {
            return _tileGenerator(i);
          }),
          staggeredTiles: _tilesForView(),
        ),
      ),
    );
  }

  int _colForStaggeredView(BuildContext context) {
    if (widget.notesViewType == viewType.List) return 1;
    // for width larger than 600 on grid mode, return 3 irrelevant of the orientation to accommodate more notes horizontally
    return MediaQuery.of(context).size.width > 600 ? 3 : 2;
  }

  List<StaggeredTile> _tilesForView() {
    // Generate staggered tiles for the view based on the current preference.
    return List.generate(noteBox.length, (index) {
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

  NoteTile _tileGenerator(int i) {
    return NoteTile(
      i,
      Note(
        title: noteBox.getAt(i)!.title,
        content: noteBox.getAt(i)!.content,
      ),
    );
  }
}
