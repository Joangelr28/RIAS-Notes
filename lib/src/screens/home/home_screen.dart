import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/src/models/models.dart';
import 'package:notes_app/src/models/quick_note.dart';
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
  final autoSizeGroup = AutoSizeGroup();

  List pageList = <String>[
    'Notes',
    'Quick Notes',
  ];

  List iconList = <IconData>[
    Icons.note,
    Icons.note_add_outlined,
  ];

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
          pageList[activeIndex],
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _widgetsOptions.elementAt(activeIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            activeIndex == 0 ? Colors.blueAccent : Colors.orangeAccent,
        tooltip: "Center Button",
        child: Icon(Icons.add),
        onPressed: () => _createNotes(context),
        elevation: 2,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          Color color;
          if (activeIndex == 0 && isActive) {
            color = Colors.blueAccent;
          } else if (activeIndex == 1 && isActive) {
            color = Colors.orangeAccent;
          } else {
            color = Colors.black87;
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  pageList[index],
                  maxLines: 1,
                  style: TextStyle(
                    color: color,
                  ),
                  group: autoSizeGroup,
                ),
              ),
            ],
          );
        },
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        rightCornerRadius: 32,
        leftCornerRadius: 32,
        activeIndex: activeIndex,
        onTap: (index) => setState(() => activeIndex = index),
      ),
    );
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
