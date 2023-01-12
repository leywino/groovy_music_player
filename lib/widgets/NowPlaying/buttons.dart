import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/most_played_model.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/screens/splash.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/add_to_playlist.dart';
import 'package:firstproject/widgets/functions.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NPButtons extends StatefulWidget {
  static ValueNotifier<bool> playingOrNot = ValueNotifier(isPlaying);
  static bool isPlaying = false;
  NPButtons({super.key, required this.intindex});

  int intindex = HomeBottomTile.intindex;
  Duration duration = const Duration();
  Duration position = const Duration();

  @override
  State<NPButtons> createState() => _NPButtonsState();
}

bool skipSeekBool = true;
bool prevSeekBool = true;
bool willRepeat = false;
List<Audio> convert = [];
AssetsAudioPlayer player = AssetsAudioPlayer.withId('key');
final recentlybox = RecentlyBox.getInstance();
List<Most> mostdb = mostbox.values.toList();

class _NPButtonsState extends State<NPButtons> {
  @override
  void initState() {
    List<Songs> songdb = songbox.values.toList();
    for (var item in songdb) {
      convert.add(
        Audio.file(
          item.songurl!,
          metas: Metas(
            title: item.songname,
            artist: item.artist,
            id: item.id.toString(),
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final box = SongBox.getInstance();
    List<Songs> songdb = box.values.toList();

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
                    onTap: () {
                      setState(() {
                        willRepeat = !willRepeat;
                      });
                      !willRepeat
                          ? player.setLoopMode(LoopMode.none)
                          : player.setLoopMode(LoopMode.single);
                    },
                    child: willRepeat
                        ? const Icon(
                            Icons.repeat,
                            color: Colors.green,
                            size: 35,
                          )
                        : const Icon(
                            Icons.repeat,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                  GestureDetector(
                    onHorizontalDragStart: (details) async {
                      await player.seekBy(const Duration(seconds: -10));
                      setState(() {
                        prevSeekBool = !prevSeekBool;
                      });
                      await Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          prevSeekBool = !prevSeekBool;
                        });
                      });
                      // setState(() {
                      //   prevSeekBool = !prevSeekBool;
                      // });
                    },
                    onTap: checkIndexPrev(widget.intindex, songdb)
                        ? null
                        : () async {
                            previousMusic(
                                isPlaying, player, songdb, widget.intindex);
                            if (isPlaying == false) {
                              await player.pause();
                            }
                            await player.previous();
                          },
                    child: Icon(
                      prevSeekBool
                          ? Icons.skip_previous
                          : Icons.fast_rewind_rounded,
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
                    onHorizontalDragStart: (details) async {
                      await player.seekBy(const Duration(seconds: 10));
                      setState(() {
                        skipSeekBool = !skipSeekBool;
                      });
                      await Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          skipSeekBool = !skipSeekBool;
                        });
                      });
                      // setState(() {
                      //   prevSeekBool = !prevSeekBool;
                      // });
                    },
                    onTap: checkIndexSkip(widget.intindex, songdb)
                        ? null
                        : () async {
                            skipMusic(
                                isPlaying, player, songdb, widget.intindex);
                            if (isPlaying == false) {
                              await player.pause();
                            }
                            await player.next();
                          },
                    child: Icon(
                      skipSeekBool
                          ? Icons.skip_next
                          : Icons.fast_forward_rounded,
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
                    child: const Icon(
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
  intindex++;
  NowPlayingScreen.spindex.value++;
  HomeBottomTile.vindex.value++;
  Most mostsongs = mostdb[intindex];
  checkMostPlayed(mostsongs, intindex);
  // await player.open(
  //   Audio.file(songdb[intindex].songurl!),
  //   playInBackground: PlayInBackground.disabledPause,
  //   audioFocusStrategy: const AudioFocusStrategy.request(
  //     resumeAfterInterruption: true,
  //     resumeOthersPlayersAfterDone: true,
  //   ),
  // );
  // await player.open(Playlist(audios: convert, startIndex: intindex),
  //     showNotification: true,
  //     headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
  //     loopMode: LoopMode.playlist);
  // Recently recsongs = Recently(
  //     songname: songdb[intindex].songname,
  //     artist: songdb[intindex].artist,
  //     duration: songdb[intindex].duration,
  //     songurl: songdb[intindex].songurl,
  //     id: songdb[intindex].id);
  // checkRecentlyPlayed(recsongs, intindex);
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

  Most mostsongs = mostdb[intindex];
  checkMostPlayed(mostsongs, intindex);
  // await player.open(
  //   Audio.file(songdb[intindex].songurl!),
  //   playInBackground: PlayInBackground.disabledPause,
  //   audioFocusStrategy: AudioFocusStrategy.request(
  //     resumeAfterInterruption: true,
  //     resumeOthersPlayersAfterDone: true,
  //   ),
  // );
  // await player.open(Playlist(audios: convert, startIndex: intindex),
  //     showNotification: true,
  //     headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
  //     loopMode: LoopMode.playlist);
  // Recently recsongs = Recently(
  //     songname: songdb[intindex].songname,
  //     artist: songdb[intindex].artist,
  //     duration: songdb[intindex].duration,
  //     songurl: songdb[intindex].songurl,
  //     id: songdb[intindex].id);
  // checkRecentlyPlayed(recsongs, intindex);
  // await player.play();
}

playMusic(bool isPlaying, AssetsAudioPlayer player, List<Songs> songdb,
    int intindex) async {
  await player.open(
    Audio.file(songdb[intindex].songurl!),
    showNotification: notificationBool,
    playInBackground: PlayInBackground.disabledPause,
    audioFocusStrategy: const AudioFocusStrategy.request(
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
