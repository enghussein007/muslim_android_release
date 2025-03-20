import 'package:calendar/app/calendar/home.dart';
import 'package:flutter/material.dart';
import 'app/shared/network/local/shared_prefernce.dart';
import 'app/shared/network/remote/location_service.dart';
import 'app/shared/utils/size_config.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AuthServices.getPosition();
  await CachHelper.init();
  CachHelper.getData(key: 'num');
  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const MyApp(), // Wrap your app
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: "Tajawal",
      ),
      debugShowCheckedModeBanner: false,
      home:  HomeScreeen(),
      // darkTheme: ThemeData.dark(),
    );
  }
}



