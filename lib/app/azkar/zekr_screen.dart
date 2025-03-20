import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/utils/size_config.dart';

class AzkarListScreen extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> azkarList;

  const AzkarListScreen({super.key, required this.title, required this.azkarList});

  @override
  _AzkarListScreenState createState() => _AzkarListScreenState();
}

class _AzkarListScreenState extends State<AzkarListScreen> {
  late List<Map<String, dynamic>> azkar;

  @override
  void initState() {
    super.initState();
    azkar = List.from(widget.azkarList); // نسخ البيانات لتعديل التكرارات
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: SizeConfig.defaultSize!*2.3, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: azkar.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: azkar[index]['count'] > 0
                ? () {
              SystemSound.play(SystemSoundType.click);
              HapticFeedback.selectionClick();
              setState(() {
                if (azkar[index]['count'] > 0) azkar[index]['count']--;
              });
            }
                : null,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(azkar[index]['text'], style: TextStyle(fontSize: SizeConfig.defaultSize!*1.9)),
                subtitle: Text('التكرار: ${azkar[index]['count']}',
                    style: TextStyle(fontSize: SizeConfig.defaultSize!*1.5, color: Colors.grey[600])),
                trailing: azkar[index]['count'] == 0
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}