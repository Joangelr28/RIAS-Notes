import 'package:flutter/material.dart';

class FloatingButtonHome extends StatefulWidget {
  @override
  _FloatingButtonHomeState createState() => _FloatingButtonHomeState();
}

class _FloatingButtonHomeState extends State<FloatingButtonHome> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: "Center Button",
      child: Icon(Icons.add),
      onPressed: () {},
      elevation: 2,
    );
  }
}
