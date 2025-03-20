// ------------Message Alert----------------------------

import 'package:flutter/material.dart';

Widget message({context,required String msg,required IconData icon , required Color color,required String title,
  Function ?action
})=>AlertDialog(
  contentPadding: EdgeInsets.zero,
  title: Center(child: Text(title.toUpperCase())),
  content: Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 64,
        ),
        SizedBox(height: 16),
        Text(textAlign: TextAlign.center,msg,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ),
  actions: [
    Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('OK'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
  ],
);



// ------------------Loading Dialog ----------------------
Widget dialogMessage({context,required String msg})=>Dialog(
  child: Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(textAlign: TextAlign.center,msg,
          style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 20),
        CircularProgressIndicator()
      ],
    ),
  ),

);