import 'package:firstproject/database/song_model.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NPIcon extends StatelessWidget {
  NPIcon({super.key, this.intindex, this.opendb});

  final intindex;
  final opendb;

  @override
  Widget build(BuildContext context) {
    final box = SongBox.getInstance();
    double vwh = MediaQuery.of(context).size.height;
    double vww = MediaQuery.of(context).size.width;
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
          id: opendb[intindex].id!,
          artworkQuality: FilterQuality.high,
          type: ArtworkType.AUDIO,
          artworkHeight: vwh * 0.40,
          artworkWidth: vww * 0.90,
          artworkBorder: BorderRadius.circular(10),
          artworkFit: BoxFit.cover,
          nullArtworkWidget: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/images/gradient.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
