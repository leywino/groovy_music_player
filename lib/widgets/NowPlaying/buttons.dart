import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class NPButtons extends StatefulWidget {
  NPButtons({super.key, required this.intindex});

  final int intindex;

  @override
  State<NPButtons> createState() => _NPButtonsState();
}

class _NPButtonsState extends State<NPButtons> {
  final player = AudioPlayer();
  bool pauseplay = true;
  final songs = [
    'assets/songs/Without_Me__with_Juice_WRLD_.mp3',
    'assets/songs/Jocelyn_Flores.mp3',
    'assets/songs/History.mp3',
    'assets/songs/Happier.mp3',
    'assets/songs/Everything_Black.mp3',
    'assets/songs/Older.mp3',
    'assets/songs/I_m_Good__Blue_.mp3',
    'assets/songs/Attention.mp3',
  ];
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.repeat,
            color: Colors.white,
            size: 35,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.skip_previous,
            color: Colors.white,
            size: 35,
          ),
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              pauseplay = !pauseplay;
            });
            playMusic();
          },
          child: Icon(
            pauseplay ? Icons.play_circle_fill : Icons.pause_circle_filled,
            color: Colors.white,
            size: 60,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.skip_next,
            color: Colors.white,
            size: 35,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.playlist_add,
            color: Colors.white,
            size: 35,
          ),
        ),
      ],
    );
  }

  playMusic() async {
    if (!pauseplay) {
      final duration = await player.setUrl('asset:${songs[widget.intindex]}');
      player.play();
    } else {
      player.pause();
    }
  }
}
