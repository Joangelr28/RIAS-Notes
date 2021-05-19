import 'package:flutter/material.dart';
import 'package:notes_app/src/screens/components/bubble_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
          activeIcon: Icon(Icons.note),
          backgroundColor: Colors.redAccent,
          icon: Icon(Icons.note),
          title: Text('Notes'),
        ),
        BubbleBottomBarItem(
          activeIcon: Icon(Icons.note_add_outlined),
          backgroundColor: Colors.blueAccent,
          icon: Icon(Icons.note_add_outlined),
          title: Text('Quick Notes'),
        ),
      ],
      opacity: .2,
    );
  }
}
