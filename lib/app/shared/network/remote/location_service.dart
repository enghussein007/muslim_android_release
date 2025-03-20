import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class AuthServices {
  static Position? cl;
  static double? distanceInMeters;

  static Future getPosition() async {
    bool services;
    LocationPermission permission;

    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      Fluttertoast.showToast(
          msg: "Services Not Enabled",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // AwesomeDialog(context: ctx,title: 'Services',body: const Text('Services Not Enabled')).show();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission != LocationPermission.denied ||
        permission != LocationPermission.deniedForever) {
      return cl=await getLatAndLong();
    }
  }

  static Future<Position> getLatAndLong() async {
    return await Geolocator.getCurrentPosition().then((value) {
      //print(value);
      return value;
    }).catchError((e) {
      //print("error is ${e.toString()}");
    });
  }
}
