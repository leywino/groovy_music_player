import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class NPIcon extends StatelessWidget {
  NPIcon({super.key, this.intindex, this.opendb});

  int? intindex;
  dynamic opendb;
  final player = AssetsAudioPlayer.withId('key');

  @override
  Widget build(BuildContext context) {
    double vwh = MediaQuery.of(context).size.height;
    double vww = MediaQuery.of(context).size.width;
    return player.builderCurrent(builder: (context, playing) {
      return Padding(
        padding: EdgeInsets.all(vww * 0.05),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 2,
            ),
          ),
          child: QueryArtworkWidget(
            size: 2000,
            quality: 100,
            id: int.parse(playing.audio.audio.metas.id!),
            artworkQuality: FilterQuality.high,
            type: ArtworkType.AUDIO,
            artworkHeight: vwh * 0.40,
            artworkWidth: vww * 0.90,
            artworkBorder: BorderRadius.circular(10),
            artworkFit: BoxFit.cover,
            nullArtworkWidget: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/music.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    });
  }
}
