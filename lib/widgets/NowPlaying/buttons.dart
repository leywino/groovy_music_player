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
  static bool isPlaying = false;
  NPButtons({super.key, required this.intindex});
  int intindex = HomeBottomTile.intindex;
  Duration duration = const Duration();
  Duration position = const Duration();

  @override
  State<NPButtons> createState() => _NPButtonsState();
}

ValueNotifier<bool> willRepeatNotifier = ValueNotifier(false);

List<Audio> convert = [];
AssetsAudioPlayer player = AssetsAudioPlayer.withId('key');
final recentlybox = RecentlyBox.getInstance();
List<Most> mostdb = mostbox.values.toList();

class _NPButtonsState extends State<NPButtons> {
  @override
  Widget build(BuildContext context) {
    final box = SongBox.getInstance();
    List<Songs> songdb = box.values.toList();

    return player.builderCurrent(builder: (context, playing) {
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
                    ValueListenableBuilder(
                      valueListenable: willRepeatNotifier,
                      builder: (context, willRepeat, child) => GestureDetector(
                        onTap: () {
                          willRepeatNotifier.value = !willRepeatNotifier.value;
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
                    ),
                    GestureDetector(
                      onTap: checkIndexPrev(widget.intindex, playing)
                          ? null
                          : () async {
                              previousMusic(
                                  isPlaying, player, songdb, widget.intindex);
                              if (isPlaying == false) {
                                await player.pause();
                              }
                              await player.previous();
                              int songindex = songdb.indexWhere((element) =>
                                  element.songname ==
                                  playing.audio.audio.metas.title);
                              Recently recsongs = Recently(
                                  songname: songdb[songindex].songname,
                                  artist: songdb[songindex].artist,
                                  duration: songdb[songindex].duration,
                                  songurl: songdb[songindex].songurl,
                                  id: songdb[songindex].id,
                                  index: songindex);
                              checkRecentlyPlayed(recsongs);
                            },
                      child: Icon(
                        Icons.skip_previous,
                        color: checkIndexPrev(widget.intindex, playing)
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
                      onTap: checkIndexSkip(widget.intindex, playing)
                          ? null
                          : () async {
                              skipMusic(
                                  isPlaying, player, songdb, widget.intindex);
                              if (isPlaying == false) {
                                await player.pause();
                              }
                              await player.next();
                              int songindex = songdb.indexWhere((element) =>
                                  element.songname ==
                                  playing.audio.audio.metas.title);
                              Recently recsongs = Recently(
                                  songname: songdb[songindex].songname,
                                  artist: songdb[songindex].artist,
                                  duration: songdb[songindex].duration,
                                  songurl: songdb[songindex].songurl,
                                  id: songdb[songindex].id,
                                  index: songindex);
                              checkRecentlyPlayed(recsongs);
                            },
                      child: Icon(
                        Icons.skip_next,
                        color: checkIndexSkip(widget.intindex, playing)
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                        size: 35,
                      ),
                    ),
                    player.builderCurrent(builder: (context, playing) {
                      return GestureDetector(
                        onTap: () {
                          int songindex = songdb.indexWhere((element) =>
                              element.songname ==
                              playing.audio.audio.metas.title);
                          addPlaylist(context, songindex);
                        },
                        child: const Icon(
                          Icons.playlist_add,
                          color: Colors.white,
                          size: 35,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            );
          });
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

bool checkIndexSkip(int intindex, Playing playing) {
  return (intindex < playing.playlist.audios.length - 1) ? false : true;
}

bool checkIndexPrev(int intindex, Playing playing) {
  return (intindex <= 0) ? true : false;
}
