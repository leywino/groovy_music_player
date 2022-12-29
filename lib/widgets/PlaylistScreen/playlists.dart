import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/playlist_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSongList extends StatefulWidget {
  PlaylistSongList({super.key, this.intindex});
  int? intindex;

  @override
  State<PlaylistSongList> createState() => _PlaylistSongListState();
}

List<Audio> allsongs = [];

class _PlaylistSongListState extends State<PlaylistSongList> {
  @override
  void initState() {
    final playlistdb = playlistbox.values.toList();
    for (var item in playlistdb[widget.intindex!].playlistsongs) {
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

  late List<Playlists> playdb = playlistbox.values.toList();

  final player = AssetsAudioPlayer.withId('key');

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomSheet: HomeBottomTile(),
      appBar: CustomAppbar(),
      backgroundColor: mainBgColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: vww * 0.04, right: vww * 0.04, top: vwh * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  playdb[widget.intindex!].playlistname,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                GestureDetector(
                  onTap: () {
                    player.open(Playlist(audios: allsongs, startIndex: 0),
                        showNotification: true,
                        headPhoneStrategy:
                            HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                        loopMode: LoopMode.playlist);
                    player.play();
                  },
                  child: Icon(
                    Icons.play_circle,
                    color: Colors.white,
                    size: 50,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: vwh * 0.05),
            child: ListView.builder(
                itemCount: playdb[widget.intindex!].playlistsongs.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return ListTile(
                    onTap: () async {
                      final songdb = playdb[widget.intindex!].playlistsongs;
                      HomeBottomTile.vindex.value = index;
                      NowPlayingScreen.spindex.value = index;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return NowPlayingScreen(
                              intindex: 1,
                              opendb: songdb,
                            );
                          },
                        ),
                      );
                      await player.open(Audio.file(
                        playdb[widget.intindex!].playlistsongs[index].songurl!,
                      ));
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(8),
                        keepOldArtwork: true,
                        id: playdb[widget.intindex!].playlistsongs[index].id!,
                        type: ArtworkType.AUDIO,
                      ),
                    ),
                    title: Text(
                      playdb[widget.intindex!].playlistsongs[index].songname!,
                      style:
                          GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(bottom: vww * 0.035),
                      child: Text(
                        playdb[widget.intindex!].playlistsongs[index].artist!,
                        style:
                            GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}
