import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/playlist_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class PlaylistSongList extends StatefulWidget {
  static ValueNotifier<bool> hideEditNotifier = ValueNotifier(hideEdit);
  PlaylistSongList(
      {super.key, this.intindex, this.playlistname, this.playlistsongs});
  int? intindex;
  String? playlistname;
  List<Songs>? playlistsongs;
  @override
  State<PlaylistSongList> createState() => _PlaylistSongListState();
}

bool hideEdit = true;
List<Audio> allsongs = [];

class _PlaylistSongListState extends State<PlaylistSongList> {
  @override
  void initState() {
    for (var item in widget.playlistsongs!) {
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
    super.initState();
  }

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
          appBar: const CustomAppbar(),
          backgroundColor: mainBgColor,
          body: ValueListenableBuilder<Box<Playlists>>(
              valueListenable: playlistbox.listenable(),
              builder: (context, plbox, child) {
                List<Playlists> playdb = plbox.values.toList();
                List<Songs> songs = playdb[widget.intindex!].playlistsongs;
                return songs.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'No songs found in playlist',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  playdb[widget.intindex!].playlistname,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                                Wrap(
                                  spacing: 2,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    ValueListenableBuilder(
                                        valueListenable:
                                            PlaylistSongList.hideEditNotifier,
                                        builder: (context, hideEdits, value) {
                                          return GestureDetector(
                                            onTap: () {
                                              PlaylistSongList
                                                      .hideEditNotifier.value =
                                                  !PlaylistSongList
                                                      .hideEditNotifier.value;
                                            },
                                            child: hideEdits
                                                ? Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.white,
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
                                                    Icons.check_circle_rounded,
                                                    size: 38,
                                                    color: Colors.green,
                                                  ),
                                          );
                                        }),
                                    GestureDetector(
                                      onTap: () {
                                        player.open(
                                            Playlist(
                                                audios: allsongs,
                                                startIndex: 0),
                                            showNotification: notificationBool,
                                            headPhoneStrategy: HeadPhoneStrategy
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
                                      itemCount: playdb[widget.intindex!]
                                          .playlistsongs
                                          .length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: ((context, index) {
                                        return ListTile(
                                          onTap: () async {
                                            final songdb =
                                                playdb[widget.intindex!]
                                                    .playlistsongs;
                                            HomeBottomTile.vindex.value = index;
                                            NowPlayingScreen.spindex.value =
                                                index;
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
                                            player.open(
                                                Playlist(
                                                    audios: allsongs,
                                                    startIndex: index),
                                                showNotification:
                                                    notificationBool,
                                                loopMode: LoopMode.playlist);
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
                                              id: playdb[widget.intindex!]
                                                  .playlistsongs[index]
                                                  .id!,
                                              type: ArtworkType.AUDIO,
                                            ),
                                          ),
                                          title: Text(
                                            playdb[widget.intindex!]
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
                                              playdb[widget.intindex!]
                                                  .playlistsongs[index]
                                                  .artist!,
                                              style: GoogleFonts.rubik(
                                                  color: Colors.grey,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          trailing: ValueListenableBuilder(
                                              valueListenable: PlaylistSongList
                                                  .hideEditNotifier,
                                              builder:
                                                  (context, hideEdits, child) {
                                                return Visibility(
                                                  visible: !hideEdits,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      allsongs.clear();
                                                      setState(() {
                                                        songs.removeAt(index);
                                                        playdb.removeAt(
                                                            widget.intindex!);
                                                        playlistbox.putAt(
                                                            widget.intindex!,
                                                            Playlists(
                                                                playlistname: widget
                                                                    .playlistname!,
                                                                playlistsongs:
                                                                    songs));
                                                      });

                                                      Navigator.pushReplacement(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context,
                                                                  animation1,
                                                                  animation2) =>
                                                              PlaylistSongList(
                                                            intindex:
                                                                widget.intindex,
                                                            playlistname: widget
                                                                .playlistname,
                                                            playlistsongs: widget
                                                                .playlistsongs,
                                                          ),
                                                          transitionDuration:
                                                              Duration.zero,
                                                          reverseTransitionDuration:
                                                              Duration.zero,
                                                        ),
                                                      );
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
              }),
        ),
      ),
    );
  }
}
