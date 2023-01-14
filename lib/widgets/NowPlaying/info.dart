import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/favorite_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/widgets/add_to_playlist.dart';
import 'package:firstproject/widgets/functions.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NPInfo extends StatefulWidget {
  NPInfo({super.key, this.intindex, this.opendb});

  int? intindex;
  dynamic opendb;
  final player = AssetsAudioPlayer.withId('key');

  @override
  State<NPInfo> createState() => _NPInfoState();
}
List<Songs> songsdb = songbox.values.toList();
class _NPInfoState extends State<NPInfo> {
  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return widget.player.builderCurrent(
      builder: (context, playing) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: vww * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: vww * 0.75,
                      child: Text(
                        // widget.opendb[widget.intindex].songname!,
                        widget.player.getCurrentAudioTitle,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: vww * 0.75,
                      child: Text(
                        widget.player.getCurrentAudioArtist,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 22,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Favorite favval = Favorite(
                      songname: songsdb[widget.intindex!].songname,
                      artist: songsdb[widget.intindex!].artist,
                      duration: songsdb[widget.intindex!].duration,
                      songurl: songsdb[widget.intindex!].songurl,
                      id: songsdb[widget.intindex!].id);
                  addToFavorites(widget.intindex!, favval, context);
                  setState(() {});
                },
                icon: Icon(
                  checkFavoriteStatus(playing.index, context)
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color: checkFavoriteStatus(playing.index, context)
                      ? Colors.pink
                      : Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
