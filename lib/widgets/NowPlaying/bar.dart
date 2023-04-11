import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class NPBar extends StatelessWidget {
  const NPBar({super.key});

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;
    return PlayerBuilder.realtimePlayingInfos(
      player: player,
      // ignore: avoid_types_as_parameter_names
      builder: (context, realtimePlayingInfos) {
        final duration = realtimePlayingInfos.current!.audio.duration;
        final position = realtimePlayingInfos.currentPosition;
        return Padding(
          padding: EdgeInsets.only(
              left: vww * 0.06,
              right: vww * 0.06,
              top: 0.03 * vwh,
              bottom: 0.02 * vwh),
          child: ProgressBar(
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
        );
      },
    );
  }
}

AssetsAudioPlayer player = AssetsAudioPlayer.withId('key');
Duration duration = Duration.zero;
Duration position = Duration.zero;
