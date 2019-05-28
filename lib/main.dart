import 'package:flutter/material.dart';

import './pages/home_page.dart';
import './pages/converter_page.dart';
import './Utilities/ui_colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "Math Box",
      debugShowCheckedModeBanner: false,
      
      routes: {
        'Converter' : (context) => ConversionPage(),
      },
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: darkBackgroundColor,
        primaryColor: darkButtonColor
      ),
      home: new HomePage(),
    );
  }
}