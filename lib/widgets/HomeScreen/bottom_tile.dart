import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/screens/splash.dart';
import 'package:firstproject/widgets/NowPlaying/buttons.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeBottomTile extends StatefulWidget {
  static ValueNotifier<int> vindex = ValueNotifier(intindex);
  static int intindex = 0;
  static ValueNotifier<bool> isPlay = ValueNotifier(isPlaying);
  static bool isPlaying = false;

  HomeBottomTile({super.key});

  @override
  State<HomeBottomTile> createState() => _HomeBottomTileState();
}

class _HomeBottomTileState extends State<HomeBottomTile> {
  final player = AssetsAudioPlayer();
  List<Songs> songsdb = box.values.toList();
  bool pauseplay = true;

  @override
  Widget build(BuildContext context) {
    final box = SongBox.getInstance();
    List<Songs> songdb = box.values.toList();
    double vwh = MediaQuery.of(context).size.height;
    double vww = MediaQuery.of(context).size.width;
    return PlayerBuilder.isPlaying(
        player: player,
        builder: (context, isPlaying) {
          return Visibility(
            visible: true,
            child: ValueListenableBuilder(
                valueListenable: HomeBottomTile.vindex,
                builder: (BuildContext context, int intindex, child) {
                  return ValueListenableBuilder<Box<Songs>>(
                    valueListenable: box.listenable(),
                    builder: ((context, Box<Songs> allsongbox, child) {
                      List<Songs> songsdb = allsongbox.values.toList();
                      if (songsdb.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.only(
                            left: vww * 0.02, right: vww * 0.02),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => NowPlayingScreen(
                                  intindex: HomeBottomTile.intindex,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: vwh * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: vwh * 0.014,
                                  ),
                                  child: Wrap(
                                    spacing: vww * 0.02,
                                    children: [
                                      SizedBox(
                                        width: vwh * 0.075,
                                        height: vwh * 0.075,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: QueryArtworkWidget(
                                            artworkBorder:
                                                BorderRadius.circular(8),
                                            keepOldArtwork: true,
                                            id: songsdb[intindex].id!,
                                            type: ArtworkType.AUDIO,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: vww * 0.4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              songsdb[intindex].songname!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              songsdb[intindex].artist!,
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                fontSize: 20,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: vwh * 0.014,
                                  ),
                                  child: ValueListenableBuilder(
                                      valueListenable: NPButtons.playorpause,
                                      builder: (context, bool porp, child) {
                                        porp = isPlaying;

                                        return Wrap(
                                          spacing: 5,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                porp = isPlaying;
                                                HomeBottomTile.intindex--;
                                                previousMusic(porp, player,
                                                    songdb, intindex);
                                              },
                                              child: Icon(
                                                Icons.skip_previous,
                                                color: Colors.white,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                porp = isPlaying;
                                                playMusic(porp, player, songdb,
                                                    intindex);
                                              },
                                              child: Icon(
                                                !porp
                                                    ? Icons.play_circle_fill
                                                    : Icons.pause_circle_filled,
                                                color: Colors.white,
                                                size: 60,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                porp = isPlaying;
                                                HomeBottomTile.intindex++;
                                                skipMusic(isPlaying, player,
                                                    songdb, intindex);
                                              },
                                              child: Icon(
                                                Icons.skip_next,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
          );
        });
  }
}
