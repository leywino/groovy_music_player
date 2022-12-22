import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:flutter/material.dart';

class NPButtons extends StatefulWidget {
  static ValueNotifier<bool> playorpause = ValueNotifier(porp!);
  static bool? porp = true;
  NPButtons({super.key, required this.intindex, this.songs, this.songdb});

  int intindex;
  Songs? songs;
  List<Songs>? songdb;

  @override
  State<NPButtons> createState() => _NPButtonsState();
}

class _NPButtonsState extends State<NPButtons> {
  final player = AssetsAudioPlayer();
  bool pauseplay = true;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: NPButtons.playorpause,
        builder: (context, bool porp, child) {
          return PlayerBuilder.isPlaying(
            player: player,
            builder: (BuildContext context, isPlaying) {
              porp = isPlaying;
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
                    onTap: () {
                      porp = isPlaying;
                      previousMusic(
                          porp, player, widget.songdb!, widget.intindex);
                    },
                    child: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      porp = isPlaying;
                      playMusic(porp, player, widget.songdb!, widget.intindex);
                    },
                    child: Icon(
                      porp
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      porp = isPlaying;
                      skipMusic(porp, player, widget.songdb!, widget.intindex);
                    },
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
            },
          );
        });
  }
}

playMusic(bool isPlaying, AssetsAudioPlayer player, List<Songs> songdb,
    int intindex) async {
  if (!isPlaying) {
    player.open(
      Audio.file(songdb[intindex].songurl!),
    );
    player.play();
  } else {
    player.pause();
  }
  if (isPlaying) {
    HomeBottomTile.isPlay.value = true;
  }
}

skipMusic(bool isPlaying, AssetsAudioPlayer player, List<Songs> songdb,
    int intindex) async {
  if (isPlaying) {
    await player.stop();
  }
  intindex++;
  NowPlayingScreen.spindex.value++;
  HomeBottomTile.vindex.value++;

  await player.open(
    Audio.file(songdb[intindex].songurl!),
  );
  await player.play();
}

previousMusic(bool isPlaying, AssetsAudioPlayer player, List<Songs> songdb,
    int intindex) async {
  if (isPlaying) {
    await player.stop();
  }

  intindex--;
  NowPlayingScreen.spindex.value--;
  HomeBottomTile.vindex.value--;

  await player.open(
    Audio.file(songdb[intindex].songurl!),
  );
  await player.play();
}
