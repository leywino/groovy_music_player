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

class _PlaylistSongListState extends State<PlaylistSongList> {
  final playlistbox = PlaylistBox.getInstance();

  late List<Playlists> playdb = playlistbox.values.toList();

  final player = AssetsAudioPlayer.withId('key');

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainBgColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: mainBgColor,
      body: Padding(
        padding: EdgeInsets.only(top: vwh * 0.05),
        child: ListView.builder(
            itemCount: playdb[widget.intindex!].playlistsongs.length,
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
                  style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(bottom: vww * 0.035),
                  child: Text(
                    playdb[widget.intindex!].playlistsongs[index].artist!,
                    style: GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
                  ),
                ),
              );
            })),
      ),
    );
  }
}
