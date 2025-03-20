import 'package:flutter/material.dart';

class SizeConfig{

  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  static void initSize(BuildContext context){
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;
    defaultSize = orientation == Orientation.landscape ? screenHeight! * 0.025 : screenWidth! * 0.025;
    // print(defaultSize);
  }

}