import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/src/models/models.dart';
import 'package:notes_app/src/models/quick_note.dart';
import 'package:notes_app/src/screens/components/bubble_bottom_bar.dart';
import 'package:notes_app/src/screens/note_create/note_create_screen.dart';
import 'package:notes_app/src/screens/note_create/quick_note_create.dart';
import 'package:notes_app/src/screens/notes/notes_screen.dart';
import 'package:notes_app/src/screens/quick_notes/quick_notes_grid.dart';
import 'package:notes_app/src/screens/utility.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int activeIndex;
  viewType? notesViewType;

  List<Widget> _widgetsOptions = <Widget>[
    NotesScreen(),
    QuickNotesGrid(),
  ];

  @override
  void initState() {
    super.initState();
    activeIndex = 0;
    notesViewType = viewType.Staggered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        brightness: Brightness.light,
        actions: activeIndex == 0 ? _appBarActions() : [],
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          activeIndex == 0 ? "Notes" : 'QuickNotes',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _widgetsOptions.elementAt(activeIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "Center Button",
        child: Icon(Icons.add),
        onPressed: () => _createNotes(context),
        elevation: 2,
      ),
      bottomNavigationBar: BubbleBottomBar(
        onTap: _changePage,
        currentIndex: activeIndex,
        elevation: 8,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        fabLocation: BubbleBottomBarFabLocation.center,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            activeIcon: Icon(Icons.note),
            backgroundColor: Colors.redAccent,
            icon: Icon(Icons.note, color: Colors.black),
            title: Text('Notes'),
          ),
          BubbleBottomBarItem(
            activeIcon: Icon(Icons.note_add_outlined),
            backgroundColor: Colors.blueAccent,
            icon: Icon(
              Icons.note_add_outlined,
              color: Colors.black,
            ),
            title: Text('Quick Notes'),
          ),
        ],
        opacity: .2,
      ),
    );
  }

  void _changePage(index) {
    setState(() {
      activeIndex = index;
    });
  }

  void _createNotes(BuildContext context) {
    if (activeIndex == 0) {
      _newNote(context);
    } else {
      _newQuickNote(context);
    }
  }

  void _newQuickNote(BuildContext context) {
    Box<QuickNote> quickNoteBox = Hive.box('quickNotes');
    int index = quickNoteBox.length;
    QuickNote emptyQuickNote = QuickNote(
      content: [
        {'insert': '\n'}
      ],
      // color: Colors.white,
      // dateCreated: DateTime.now(),
      // dateEdited: DateTime.now(),
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QuickNoteCreateScreen(index, emptyQuickNote)));
  }

  void _newNote(BuildContext context) {
    Box<Note> noteBox = Hive.box('notes');
    int index = noteBox.length;
    Note emptyNote = Note(
      title: '',
      content: [
        {'insert': '\n'}
      ],
      // color: Colors.white,
      // dateCreated: DateTime.now(),
      // dateEdited: DateTime.now(),
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NoteCreateScreen(index, emptyNote)));
  }

  void _toggleViewType() {
    setState(() {
      CentralStation.updateNeeded = true;
      if (notesViewType == viewType.List) {
        notesViewType = viewType.Staggered;
      } else {
        notesViewType = viewType.List;
      }
    });
  }

  List<Widget> _appBarActions() {
    return [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
            onTap: () => _toggleViewType(),
            child: Icon(
              notesViewType == viewType.List
                  ? Icons.developer_board
                  : Icons.view_headline,
              color: CentralStation.fontColor,
            ),
          ),
        ),
      ),
    ];
  }
}
