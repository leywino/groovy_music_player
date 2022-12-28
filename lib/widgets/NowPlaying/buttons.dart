import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/HomeScreen/list.dart';
import 'package:firstproject/widgets/add_to_playlist.dart';
import 'package:firstproject/widgets/functions.dart';
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
final recentlybox = RecentlyBox.getInstance();

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
                    onTap: checkIndexPrev(widget.intindex, songdb)
                        ? null
                        : () {
                            previousMusic(
                                isPlaying, player, songdb, widget.intindex);
                          },
                    child: Icon(
                      Icons.skip_previous,
                      color: checkIndexPrev(widget.intindex, songdb)
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white,
                      size: 35,
                    ),
                  ),
                  PlayerBuilder.isPlaying(
                      player: player,
                      builder: (context, isPlaying) {
                        return GestureDetector(
                          onTap: () async {
                            player.playOrPause();
                          },
                          child: Icon(
                            isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: Colors.white,
                            size: 60,
                          ),
                        );
                      }),
                  GestureDetector(
                    onTap: checkIndexSkip(widget.intindex, songdb)
                        ? null
                        : () {
                            skipMusic(
                                isPlaying, player, songdb, widget.intindex);
                          },
                    child: Icon(
                      Icons.skip_next,
                      color: checkIndexSkip(widget.intindex, songdb)
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white,
                      size: 35,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      addPlaylist(context, widget.intindex);
                    },
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
    audioFocusStrategy: const AudioFocusStrategy.request(
      resumeAfterInterruption: true,
      resumeOthersPlayersAfterDone: true,
    ),
  );
  Recently recsongs = Recently(
      songname: songdb[intindex].songname,
      artist: songdb[intindex].artist,
      duration: songdb[intindex].duration,
      songurl: songdb[intindex].songurl,
      id: songdb[intindex].id);
  checkRecentlyPlayed(recsongs, intindex);
  // await player.open(
  //   Audio.file(songdb[intindex].songurl!),
  //   showNotification: true,
  //   playInBackground: PlayInBackground.disabledPause,
  //   audioFocusStrategy: const AudioFocusStrategy.request(
  //     resumeAfterInterruption: true,
  //     resumeOthersPlayersAfterDone: true,
  //   ),
  // );
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
  Recently recsongs = Recently(
      songname: songdb[intindex].songname,
      artist: songdb[intindex].artist,
      duration: songdb[intindex].duration,
      songurl: songdb[intindex].songurl,
      id: songdb[intindex].id);
  checkRecentlyPlayed(recsongs, intindex);
  // await player.play();
}

playMusic(bool isPlaying, AssetsAudioPlayer player, List<Songs> songdb,
    int intindex) async {
  await player.open(
    Audio.file(songdb[intindex].songurl!),
    showNotification: true,
    playInBackground: PlayInBackground.disabledPause,
    audioFocusStrategy: AudioFocusStrategy.request(
      resumeAfterInterruption: true,
      resumeOthersPlayersAfterDone: true,
    ),
  );
  // isPlaying ? await player.pause() : await player.play();
}

bool checkIndexSkip(int intindex, List<Songs> songdb) {
  return (intindex < songdb.length - 1) ? false : true;
}

bool checkIndexPrev(int intindex, List<Songs> songdb) {
  return (intindex <= 0) ? true : false;
}
