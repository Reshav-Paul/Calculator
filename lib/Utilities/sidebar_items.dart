import 'package:flutter/material.dart';

class SideBarItemStructure{
  final String title;
  final Color titleColor;
  final IconData icon;
  final List<SideBarItemStructure> children; //For Expansion Tiles if any

  SideBarItemStructure(this.title, this.titleColor, this.icon, this.children);
}

List<SideBarItemStructure> sideBarItems = [
  SideBarItemStructure("Conversion", Colors.white, Icons.pie_chart_outlined, []),
];