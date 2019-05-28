import 'package:flutter/material.dart';

import './basic_calculator.dart';
import './collapsing_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: new Stack(
        children: <Widget>[
          new BasicCalculator(),
          new CollapsingDrawer()
        ],
      )
    );
  }
}