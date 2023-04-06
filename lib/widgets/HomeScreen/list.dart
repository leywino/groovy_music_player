import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/bloc/all_songs/all_songs_bloc.dart';
import 'package:firstproject/bloc/favorites/favorites_bloc.dart';
import 'package:firstproject/database/favorite_model.dart';
import 'package:firstproject/database/most_played_model.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/FavoriteScreen/list.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/add_to_playlist.dart';
import 'package:firstproject/widgets/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeMusicTiles extends StatefulWidget {
  const HomeMusicTiles({super.key});

  @override
  State<HomeMusicTiles> createState() => _HomeMusicTilesState();
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
final recentlybox = RecentlyBox.getInstance();
final songbox = SongBox.getInstance();
final favoritebox = FavoriteBox.getInstance();
final mostbox = MostBox.getInstance();

class _HomeMusicTilesState extends State<HomeMusicTiles> {
  List<Audio> convert = [];
  bool favcolor = true;
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
    double vww = MediaQuery.of(context).size.width;
    return BlocBuilder<AllSongsBloc, AllSongsState>(
      builder: (context, state) {
        if (state is SongsInitial) {
          context.read<AllSongsBloc>().add(const GetAllSongs());
        }
        if (state is DisplayAllSongs) {
          if (state.songlist.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.songlist.length,
            itemBuilder: (context, index) {
              Songs songs = state.songlist[index];
              // Most mostsongs = mostlist[index];
              return ListTile(
                onTap: () async {
                  await player.open(
                      Playlist(audios: convert, startIndex: index),
                      showNotification: notificationBool,
                      headPhoneStrategy:
                          HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                      loopMode: LoopMode.playlist);
                  // checkMostPlayed(mostsongs, index);
                  Recently recsongs = Recently(
                      songname: state.songlist[index].songname,
                      artist: state.songlist[index].artist,
                      duration: state.songlist[index].duration,
                      songurl: state.songlist[index].songurl,
                      id: state.songlist[index].id,
                      index: index);
                  checkRecentlyPlayed(recsongs);
                  HomeBottomTile.vindex.value = index;
                  NowPlayingScreen.spindex.value = index;

                  // await player.open(
                  //   Audio.file(songsdb[index].songurl!),
                  //   showNotification: true,
                  //   playInBackground: PlayInBackground.disabledPause,
                  //   audioFocusStrategy: AudioFocusStrategy.request(
                  //     resumeAfterInterruption: true,
                  //     resumeOthersPlayersAfterDone: true,
                  //   ),
                  // );

                  // player.play();
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => NowPlayingScreen(
                        intindex: index,
                        opendb: state.songlist,
                      ),
                    ),
                  );
                },
                leading: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(8),
                  keepOldArtwork: true,
                  id: songs.id!,
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
                title: Text(
                  songs.songname!,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(bottom: vww * 0.035),
                  child: Text(
                    songs.artist ?? "No Artist",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.rubik(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
                trailing: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        showOptions(context, state.songlist, index);
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(
          child: Text("No Songs Found"),
        );
      },
    );
  }

  showOptions(BuildContext context, List<Songs> songdb, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: alertbg,
        content: SizedBox(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () {
                  Favorite favval = Favorite(
                      songname: songdb[index].songname,
                      artist: songdb[index].artist,
                      duration: songdb[index].duration,
                      songurl: songdb[index].songurl,
                      id: songdb[index].id);
                  // addToFavorites(favval);
                  context
                      .read<FavoritesBloc>()
                      .add(AddToFavorite(favlist: favval));

                  Navigator.pop(context);
                },
                icon: Icon(
                  !checkFavoriteStatus(index, context)
                      ? Icons.favorite_outline
                      : Icons.remove,
                  size: 30,
                  color: Colors.white,
                ),
                label: Text(
                  !checkFavoriteStatus(index, context)
                      ? 'Add to Favorites'
                      : 'Remove from Favorites',
                  style: GoogleFonts.rubik(fontSize: 18, color: Colors.white),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  addPlaylist(context, index);
                },
                icon: const Icon(
                  Icons.playlist_add,
                  size: 30,
                  color: Colors.white,
                ),
                label: Text(
                  'Add to Playlist',
                  style: GoogleFonts.rubik(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
