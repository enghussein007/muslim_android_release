import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

class QiblaCompassPage extends StatefulWidget {
  const QiblaCompassPage({super.key});

  @override
  _QiblaCompassPageState createState() => _QiblaCompassPageState();
}

class _QiblaCompassPageState extends State<QiblaCompassPage> {
  // Future<void> _checkPermissions() async {
  //   var status = await Permission.location.request();
  //   if (status.isDenied) {
  //     openAppSettings();
  //   }
  // }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اتجاه القبلة",
          style: TextStyle(
              //color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal'
          ),),
        centerTitle: true,
      ),
      body: Card(
        margin: const EdgeInsetsDirectional.all(16),
        child: FutureBuilder(
          future: Geolocator.getCurrentPosition(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("فشل في تحديد الموقع",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal'
              ),
              ),);
            }
            return const QiblaCompass();
          },
        ),
      ),
    );
  }
}

class QiblaCompass extends StatelessWidget {
  const QiblaCompass({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Center(child: Text("تعذر تحديد القبلة"));
        }

        final qiblahDirection = snapshot.data!;

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Image.asset("assets/images/compass.png", fit: BoxFit.cover,),
              ),
              Transform.rotate(
                angle: qiblahDirection.qiblah * (3.141592653589793 / 180), // تحويل إلى راديان
                child: Image.asset("assets/images/needle.png", width: 500),
              ),
              Positioned(
                bottom: 0,
                child: Text(
                  "اتجاه القبلة: ${qiblahDirection.qiblah.toStringAsFixed(2)}°",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
