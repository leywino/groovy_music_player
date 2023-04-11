import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/bloc/recently/recently_bloc.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyList extends StatelessWidget {
  RecentlyList({super.key});

  final player = AssetsAudioPlayer.withId('key');

  final List<Recently> recentplay = [];

  final box = RecentlyBox.getInstance();

  List<Audio> recentplayedaudio = [];

  @override
  Widget build(BuildContext context) {
    final vww = MediaQuery.of(context).size.width;
    final vwh = MediaQuery.of(context).size.height;
    return BlocBuilder<RecentlyBloc, RecentlyState>(
      builder: (context, state) {
        if (state is RecentlyInitial) {
          context.read<RecentlyBloc>().add(const GetAllRecently());
        }
        if (state is DisplayRecentlyState) {
          final List<Recently> recentdb = box.values.toList();
          for (var item in recentdb) {
            recentplayedaudio.add(
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
          return state.recentlylist.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: vwh * 0.25),
                  child: const Center(
                    child: Text(
                      'You have no recently played songs!',
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  ),
                )
              : ListView.builder(
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.recentlylist.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: QueryArtworkWidget(
                          artworkBorder: BorderRadius.circular(8),
                          keepOldArtwork: true,
                          id: state.recentlylist[index].id!,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              'assets/images/music.jpg',
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        state.recentlylist[index].songname!,
                        style: GoogleFonts.rubik(
                            fontSize: 20, color: Colors.white),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(bottom: vww * 0.035),
                        child: Text(
                          state.recentlylist[index].artist!,
                          style: GoogleFonts.rubik(
                              color: Colors.grey, fontSize: 18),
                        ),
                      ),
                      onTap: () async {
                        // HomeBottomTile.vindex.value = index;
                        // NowPlayingScreen.spindex.value = index;
                        await player.open(
                            Playlist(
                                audios: recentplayedaudio, startIndex: index),
                            showNotification: true,
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                            loopMode: LoopMode.playlist);
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => NowPlayingScreen(
                              intindex: state.recentlylist[index].index!,
                              opendb: state.recentlylist,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                );
        }
        return Padding(
          padding: EdgeInsets.only(top: vwh * 0.25),
          child: const Center(
            child: Text(
              'You have no recently played songs!',
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          ),
        );
      },
    );
  }
}
