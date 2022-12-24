import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:flutter/material.dart';

class NPButtons extends StatefulWidget {
  static ValueNotifier<bool> playingOrNot = ValueNotifier(isPlaying);
  static bool isPlaying = false;
  NPButtons({super.key, required this.intindex});

  int intindex = HomeBottomTile.intindex;
  Duration duration = Duration();
  Duration position = Duration();

  @override
  State<NPButtons> createState() => _NPButtonsState();
}

AssetsAudioPlayer player = AssetsAudioPlayer.withId('key');

class _NPButtonsState extends State<NPButtons> {
  @override
  Widget build(BuildContext context) {
    final box = SongBox.getInstance();
    List<Songs> songdb = box.values.toList();

    double vwh = MediaQuery.of(context).size.height;

    return PlayerBuilder.isPlaying(
        player: player,
        builder: (context, isPlaying) {
          return Column(
            children: [
              Wrap(
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
                      previousMusic(isPlaying, player, songdb, widget.intindex);
                    },
                    child: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      playMusic(isPlaying, player, songdb, widget.intindex);
                    },
                    child: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      skipMusic(isPlaying, player, songdb, widget.intindex);
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
              ),
            ],
          );
        });
  }
}

skipMusic(bool isPlaying, AssetsAudioPlayer player, List<Songs> songdb,
    int intindex) async {
  await player.playOrPause();
  intindex++;
  NowPlayingScreen.spindex.value++;
  HomeBottomTile.vindex.value++;

  await player.open(
    Audio.file(songdb[intindex].songurl!),
    playInBackground: PlayInBackground.disabledPause,
    audioFocusStrategy: AudioFocusStrategy.request(
      resumeAfterInterruption: true,
      resumeOthersPlayersAfterDone: true,
    ),
  );
  await player.play();
}

previousMusic(bool isPlaying, AssetsAudioPlayer player, List<Songs> songdb,
    int intindex) async {
  intindex--;
  NowPlayingScreen.spindex.value--;
  HomeBottomTile.vindex.value--;
  await player.open(
    Audio.file(songdb[intindex].songurl!),
    playInBackground: PlayInBackground.disabledPause,
    audioFocusStrategy: AudioFocusStrategy.request(
      resumeAfterInterruption: true,
      resumeOthersPlayersAfterDone: true,
    ),
  );
  await player.play();
}

playMusic(bool isPlaying, AssetsAudioPlayer player, List<Songs> songdb,
    int intindex) async {
  await player.open(
    Audio.file(songdb[intindex].songurl!),
    playInBackground: PlayInBackground.disabledPause,
    audioFocusStrategy: AudioFocusStrategy.request(
      resumeAfterInterruption: true,
      resumeOthersPlayersAfterDone: true,
    ),
  );
  isPlaying ? await player.pause() : await player.play();
}
