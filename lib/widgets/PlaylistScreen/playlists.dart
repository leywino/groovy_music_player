import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/bloc/playlist/playlist_bloc.dart';
import 'package:firstproject/database/playlist_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class PlaylistSongList extends StatelessWidget {
  static ValueNotifier<bool> hideEditNotifier = ValueNotifier(hideEdit);
  PlaylistSongList({super.key});

  // @override
  final playlistbox = PlaylistBox.getInstance();

  final player = AssetsAudioPlayer.withId('key');

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white.withOpacity(0),
      child: SafeArea(
        child: Scaffold(
            bottomSheet: HomeBottomTile(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: mainBgColor,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: BlocBuilder<PlaylistBloc, PlaylistState>(
                      builder: (ctx, state) {
                        return IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ctx
                                .read<PlaylistBloc>()
                                .add(const GetAllPlaylist());
                          },
                          icon: const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    )),
              ),
            ),
            backgroundColor: mainBgColor,
            body: BlocBuilder<PlaylistBloc, PlaylistState>(
              builder: (context, state) {
                final playdb = playlistbox.values.toList();
                if (state is SpecificPlaylistShow) {
                  List<Songs> songs = state.songdb;
                  return songs.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                'No songs found in playlist',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: vww * 0.04,
                                  right: vww * 0.04,
                                  top: vwh * 0.02),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    playdb[state.index].playlistname,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  Wrap(
                                    spacing: 2,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable:
                                              hideEditNotifier,
                                          builder: (context, hideEdits, value) {
                                            return GestureDetector(
                                              onTap: () {
                                                hideEditNotifier
                                                        .value =
                                                    !hideEditNotifier.value;
                                              },
                                              child: hideEdits
                                                  ? Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: mainBgColor,
                                                          size: 28,
                                                        ),
                                                      ),
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      size: 38,
                                                      color: Colors.green,
                                                    ),
                                            );
                                          }),
                                      GestureDetector(
                                        onTap: () async {
                                          await player.open(
                                              Playlist(
                                                  audios: allsongs,
                                                  startIndex: 0),
                                              showNotification:
                                                  notificationBool,
                                              headPhoneStrategy:
                                                  HeadPhoneStrategy
                                                      .pauseOnUnplugPlayOnPlug,
                                              loopMode: LoopMode.playlist);
                                          // player.play();
                                        },
                                        child: const Icon(
                                          Icons.play_circle,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: vwh * 0.05),
                                child: ValueListenableBuilder<Box<Playlists>>(
                                  valueListenable: playlistbox.listenable(),
                                  builder: (context, Box<Playlists> playlistbox,
                                      child) {
                                    final List<Playlists> playdb =
                                        playlistbox.values.toList();
                                    return ListView.builder(
                                        itemCount: playdb[state.index]
                                            .playlistsongs
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: ((context, index) {
                                          return ListTile(
                                            onTap: () async {
                                              if (allsongs.isEmpty) {
                                                for (var item in state.songdb) {
                                                  allsongs.add(
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
                                                await player.open(
                                                    Playlist(
                                                        audios: allsongs,
                                                        startIndex: index),
                                                    showNotification:
                                                        notificationBool,
                                                    loopMode:
                                                        LoopMode.playlist);
                                              }
                                              await player.open(
                                                  Playlist(
                                                      audios: allsongs,
                                                      startIndex: index),
                                                  showNotification:
                                                      notificationBool,
                                                  loopMode: LoopMode.playlist);
                                              final songdb = playdb[state.index]
                                                  .playlistsongs;
                                              HomeBottomTile.vindex.value =
                                                  index;
                                              NowPlayingScreen.spindex.value =
                                                  index;
                                              // ignore: use_build_context_synchronously
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (ctx) {
                                                    return NowPlayingScreen(
                                                      intindex: index,
                                                      opendb: songdb,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: QueryArtworkWidget(
                                                artworkBorder:
                                                    BorderRadius.circular(8),
                                                nullArtworkWidget: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.asset(
                                                    'assets/images/music.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                keepOldArtwork: true,
                                                id: playdb[state.index]
                                                    .playlistsongs[index]
                                                    .id!,
                                                type: ArtworkType.AUDIO,
                                              ),
                                            ),
                                            title: Text(
                                              playdb[state.index]
                                                  .playlistsongs[index]
                                                  .songname!,
                                              style: GoogleFonts.rubik(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            subtitle: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: vww * 0.035),
                                              child: Text(
                                                playdb[state.index]
                                                    .playlistsongs[index]
                                                    .artist!,
                                                style: GoogleFonts.rubik(
                                                    color: Colors.grey,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            trailing: ValueListenableBuilder(
                                                valueListenable:
                                                    hideEditNotifier,
                                                builder: (context, hideEdits,
                                                    child) {
                                                  return Visibility(
                                                    visible: !hideEdits,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        songs.removeAt(index);
                                                        playdb.removeAt(
                                                            state.index);
                                                        playlistbox.putAt(
                                                            state.index,
                                                            Playlists(
                                                                playlistname: state
                                                                    .playlistname,
                                                                playlistsongs:
                                                                    songs));

                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder: (context,
                                                                    animation1,
                                                                    animation2) =>
                                                                PlaylistSongList(),
                                                            transitionDuration:
                                                                Duration.zero,
                                                            reverseTransitionDuration:
                                                                Duration.zero,
                                                          ),
                                                        );

                                                        // Navigator.pushReplacement(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           PlaylistSongList(
                                                        //         intindex: widget
                                                        //             .intindex,
                                                        //         playlistname: widget
                                                        //             .playlistname,
                                                        //         playlistsongs: widget
                                                        //             .playlistsongs,
                                                        //       ),
                                                        //     ));
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          );
                                        }));
                                  },
                                )),
                          ],
                        );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'No songs found in playlist',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}

bool hideEdit = true;
List<Audio> allsongs = [];
