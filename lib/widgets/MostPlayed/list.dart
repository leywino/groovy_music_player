import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/bloc/most/most_bloc.dart';
import 'package:firstproject/database/most_played_model.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostLists extends StatelessWidget {
  const MostLists({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    mostInitstate();
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;
    return mostsongslist.isEmpty
        ? Padding(
            padding: EdgeInsets.only(top: vwh * 0.25),
            child: const Center(
              child: Text(
                'You have no most played songs!',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          )
        : BlocBuilder<MostBloc, MostState>(
            builder: (context, state) {
              if (state is MostInitial) {
                context.read<MostBloc>().add(const GetMostSongs());
              }
              if (state is DisplayMostSongs) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mostsongslist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      // onTap: null,
                      onTap: () async {
                        getMostSongs();
                        // HomeBottomTile.vindex.value = index;
                        // NowPlayingScreen.spindex.value = index;
                        await player.open(
                            Playlist(audios: songdb, startIndex: index),
                            showNotification: notificationBool,
                            headPhoneStrategy:
                                HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                            loopMode: LoopMode.playlist);
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => NowPlayingScreen(
                              intindex: mostdb[index].index,
                              opendb: mostdb,
                            ),
                          ),
                        );

                        // await player.open(
                        //   Audio.file(mostsongslist[index].songurl),
                        //   showNotification: notificationBool,
                        //   playInBackground: PlayInBackground.disabledPause,
                        //   audioFocusStrategy: const AudioFocusStrategy.request(
                        //     resumeAfterInterruption: true,
                        //     resumeOthersPlayersAfterDone: true,
                        //   ),
                        // );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: QueryArtworkWidget(
                          artworkBorder: BorderRadius.circular(8),
                          keepOldArtwork: true,
                          nullArtworkWidget: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              'assets/images/music.jpg',
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          id: mostsongslist[index].id,
                          type: ArtworkType.AUDIO,
                        ),
                      ),
                      title: Text(
                        mostsongslist[index].songname,
                        style: GoogleFonts.rubik(
                            fontSize: 20, color: Colors.white),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(bottom: vww * 0.035),
                        child: Text(
                          mostsongslist[index].artist,
                          style: GoogleFonts.rubik(
                              color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    );
                  },
                );
              }
              return Padding(
                padding: EdgeInsets.only(top: vwh * 0.25),
                child: const Center(
                  child: Text(
                    'You have no most played songs!',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              );
            },
          );
  }
}

final recentlybox = RecentlyBox.getInstance();
final mostbox = MostBox.getInstance();
final player = AssetsAudioPlayer.withId('key');
List<Recently> recentlysongslist = [];
List<Audio> songdb = [];
List<Most> mostsongslist = [];
List<Most> mostdb = mostbox.values.toList();

bool checkIndexSkip(int intindex, List<Most> mostdb) {
  return (intindex < mostdb.length - 1) ? false : true;
}

bool checkIndexPrev(int intindex, List<Most> mostdb) {
  return (intindex <= 0) ? true : false;
}

void mostInitstate() {
  List<Most> songlist = mostbox.values.toList();
  int i = 0;
  for (var item in songlist) {
    if (item.count > 5 &&
        mostsongslist
            .where((element) => element.songname == item.songname)
            .isEmpty) {
      mostsongslist.insert(i, item);
      i++;
    }
  }
}

void getMostSongs() {
  for (var items in mostsongslist) {
    songdb.add(Audio.file(items.songurl,
        metas: Metas(
            title: items.songname,
            artist: items.artist,
            id: items.id.toString())));
  }
}
