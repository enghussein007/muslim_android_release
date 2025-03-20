import 'package:calendar/app/shared/styles/colors.dart';
import 'package:calendar/app/shared/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class QuranRadioWidget extends StatefulWidget {
  const QuranRadioWidget({super.key});

  @override
  _QuranRadioWidgetState createState() => _QuranRadioWidgetState();
}

class _QuranRadioWidgetState extends State<QuranRadioWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  final String radioUrl = 'https://stream.radiojar.com/8s5u5tpdtwzuv';

  void _togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.setUrl(radioUrl);
      await _audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

// Listen for changes and update UI correctly
  void _initAudioPlayer() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlayingNow = playerState.playing;
      if (isPlaying != isPlayingNow) {
        setState(() {
          isPlaying = isPlayingNow;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAudioPlayer();
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اذاعة القران الكريم',style: TextStyle(fontSize: SizeConfig.defaultSize!*3.0, fontWeight: FontWeight.bold),),),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _togglePlayPause,
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          label: Text('اذاعة القران الكريم المصرية',
              style: TextStyle(
                  fontSize: SizeConfig.defaultSize!*2.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal"
              )),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: const TextStyle(fontSize: 18),
            backgroundColor: defaultColor,
              foregroundColor: Colors.white
          ),
        ),
      ),
    );
  }
}
