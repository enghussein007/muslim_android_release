import 'package:calendar/app/azkar/zekr_screen.dart';
import 'package:flutter/material.dart';

import '../shared/utils/size_config.dart';
import 'azkar_constants.dart';

class AzkarHomeScreen extends StatelessWidget {
  const AzkarHomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الأذكار',
          style: TextStyle(fontSize: SizeConfig.defaultSize!*2.5, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: azkarCategories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AzkarListScreen(
                      title: azkarCategories[index]['title'],
                      azkarList: azkarCategories[index]['azkar'],
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(azkarCategories[index]['icon'], size: 40, color: Colors.teal),
                    const SizedBox(height: 10),
                    Text(
                      azkarCategories[index]['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.defaultSize!*1.9, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}