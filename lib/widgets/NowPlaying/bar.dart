import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class NPBar extends StatefulWidget {
  NPBar({super.key, this.intindex, this.songdb});

  List<Songs>? songdb;
  int? intindex;
  Duration _duration = Duration();
  Duration _position = Duration();

  @override
  State<NPBar> createState() => _NPBarState();
}

class _NPBarState extends State<NPBar> {
  final player = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    double vwh = MediaQuery.of(context).size.height;
    double vww = MediaQuery.of(context).size.width;
    return PlayerBuilder.realtimePlayingInfos(
      player: player,
      builder: (context, RealtimePlayingInfos) {
        final duration = RealtimePlayingInfos.current!.audio.duration;
        final position = RealtimePlayingInfos.currentPosition;

        return Column(
          children: [
            ProgressBar(
              baseBarColor: Colors.white.withOpacity(0.5),
              progressBarColor: Colors.white,
              thumbColor: Colors.white,
              thumbRadius: 5,
              timeLabelPadding: 5,
              progress: position,
              timeLabelTextStyle: const TextStyle(color: Colors.white),
              total: duration,
              onSeek: (duration) async {
                // print('User selected a new time: $duration');
                await player.seek(duration);
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: vww * 0.05, right: vww * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0:53',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    '3:49',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
