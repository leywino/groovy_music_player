import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/FavoriteScreen/list.dart';
import 'package:flutter/material.dart';

class FavoriteTitle extends StatelessWidget {
  const FavoriteTitle({super.key});

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: vww * 0.05, vertical: vwh * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: homeCard22,
                size: 45,
              ),
              Text(
                favorites,
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ],
          ),
          player.builderIsPlaying(
            builder: (context, isPlaying) {
              final favSongsdb = favoritebox.values.toList();
              for (var item in favSongsdb) {
                allfavaudio.add(
                  Audio.file(
                    item.songurl.toString(),
                    metas: Metas(
                      artist: item.artist,
                      title: item.songname,
                      id: item.id.toString(),
                    ),
                  ),
                );
              }
              return GestureDetector(
                onTap: () {
                  if (!isPlaying) {
                    player.open(Playlist(audios: allfavaudio, startIndex: 0),
                        showNotification: notificationBool,
                        headPhoneStrategy:
                            HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                        loopMode: LoopMode.playlist);
                  } else {
                    player.stop();
                  }
                },
                child: Icon(
                  isPlaying ? Icons.stop_circle : Icons.play_circle,
                  color: Colors.white,
                  size: 50,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

List<Audio> allfavaudio = [];
