import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/bloc/favorites/favorites_bloc.dart';
import 'package:firstproject/database/favorite_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteLists extends StatelessWidget {
  const FavoriteLists({super.key});
  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;

    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoriteInitial) {
          context.read<FavoritesBloc>().add(const GetAllFavs());
        }
        if (state is DisplayAllFavs) {
          final List<Favorite> favouritesongs = favoritebox.values.toList();
          for (var item in favouritesongs) {
            allfavaudio.add(
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
          return state.favlist.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: vwh * 0.25),
                  child: const Center(
                    child: Text(
                      'You have no favorite songs!',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.favlist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        // getFavoriteSongs();
                        if (allfavaudio.isEmpty) {
                          for (var item in state.favlist) {
                            allfavaudio.add(
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
                              Playlist(audios: allfavaudio, startIndex: index),
                              showNotification: notificationBool,
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                              loopMode: LoopMode.playlist);
                        }
                        await player.open(
                            Playlist(audios: allfavaudio, startIndex: index),
                            showNotification: notificationBool,
                            headPhoneStrategy:
                                HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                            loopMode: LoopMode.playlist);
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => NowPlayingScreen(),
                          ),
                        );
                        // player.play();
                        // await player.open(
                        //   Audio.file(state.favlist[index].songurl!),
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
                          id: state.favlist[index].id!,
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
                        state.favlist[index].songname!,
                        style: GoogleFonts.rubik(
                            fontSize: 20, color: Colors.white),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(bottom: vww * 0.035),
                        child: Text(
                          state.favlist[index].artist!,
                          style: GoogleFonts.rubik(
                              color: Colors.grey, fontSize: 18),
                        ),
                      ),
                      trailing: Padding(
                        padding: EdgeInsets.only(bottom: vww * 0.035),
                        child: IconButton(
                          onPressed: () async {
                            allfavaudio.clear();
                            context
                                .read<FavoritesBloc>()
                                .add(RemoveFromFavorite(index: index));
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              content: Text("Removed from favorites"),
                            ));
                            // ignore: use_build_context_synchronously
                            // Navigator.pushReplacement(
                            //   context,
                            //   PageRouteBuilder(
                            //     pageBuilder:
                            //         (context, animation1, animation2) =>
                            //             const ScreenFavorites(),
                            //     transitionDuration: Duration.zero,
                            //     reverseTransitionDuration: Duration.zero,
                            //   ),
                            // );
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 25,
                          ),
                        ),
                      ),
                    );
                  },
                );
        }
        return const Center(
          child: Text("You dont have favourite songs"),
        );
      },
    );
  }
}

final favoritebox = FavoriteBox.getInstance();
final player = AssetsAudioPlayer.withId('key');
List<Favorite> favsongslist = [];
List<Audio> allfavaudio = [];

bool checkIndexSkip(int intindex, List<Favorite> favdb) {
  return (intindex < favdb.length - 1) ? false : true;
}

bool checkIndexPrev(int intindex, List<Favorite> favdb) {
  return (intindex <= 0) ? true : false;
}
