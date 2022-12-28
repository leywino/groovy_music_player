import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/favorite_model.dart';
import 'package:firstproject/database/recently_played.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/add_to_playlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeMusicTiles extends StatefulWidget {
  HomeMusicTiles({super.key});

  @override
  State<HomeMusicTiles> createState() => _HomeMusicTilesState();
}

final recentlybox = RecentlyBox.getInstance();
final songbox = SongBox.getInstance();
final favoritebox = FavoriteBox.getInstance();

class _HomeMusicTilesState extends State<HomeMusicTiles> {
  final player = AssetsAudioPlayer.withId('key');
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
    List<Favorite> favdb = favoritebox.values.toList();
    return ValueListenableBuilder<Box<Songs>>(
      valueListenable: songbox.listenable(),
      builder: ((context, Box<Songs> allsongbox, child) {
        List<Songs> songsdb = allsongbox.values.toList();
        if (songsdb.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: songsdb.length,
          itemBuilder: (context, index) {
            Songs songs = songsdb[index];
            return ListTile(
              onTap: () async {
                Recently recsongs = Recently(
                    songname: songsdb[index].songname,
                    artist: songsdb[index].artist,
                    duration: songsdb[index].duration,
                    songurl: songsdb[index].songurl,
                    id: songsdb[index].id);
                checkRecentlyPlayed(recsongs, index);
                HomeBottomTile.vindex.value = index;
                NowPlayingScreen.spindex.value = index;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => NowPlayingScreen(
                      intindex: index,
                      opendb: songsdb,
                    ),
                  ),
                );
                // await player.open(
                //   Audio.file(songsdb[index].songurl!),
                //   showNotification: true,
                //   playInBackground: PlayInBackground.disabledPause,
                //   audioFocusStrategy: AudioFocusStrategy.request(
                //     resumeAfterInterruption: true,
                //     resumeOthersPlayersAfterDone: true,
                //   ),
                // );
                player.open(Playlist(audios: convert, startIndex: index),
                    showNotification: true,
                    headPhoneStrategy:
                        HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                    loopMode: LoopMode.playlist);
                player.play();
              },
              leading: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(8),
                keepOldArtwork: true,
                id: songs.id!,
                type: ArtworkType.AUDIO,
              ),
              title: Text(
                songs.songname!,
                style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(bottom: vww * 0.035),
                child: Text(
                  songs.artist ?? "No Artist",
                  style: GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
                ),
              ),
              trailing: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      showOptions(context, songsdb, index);
                    },
                    icon: Icon(
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
      }),
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
                  addToFavorites(index, favval, context);
                  Navigator.pop(context);
                },
                icon: Icon(
                  !checkFavoriteStatus(index, songdb, context)
                      ? Icons.favorite_outline
                      : Icons.remove,
                  size: 30,
                  color: Colors.white,
                ),
                label: Text(
                  !checkFavoriteStatus(index, songdb, context)
                      ? 'Add to Favorites'
                      : 'Remove from Favorites',
                  style: GoogleFonts.rubik(fontSize: 18, color: Colors.white),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  addPlaylist(context, index);
                },
                icon: Icon(
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

checkRecentlyPlayed(Recently value, index) {
  List<Recently> list = recentlybox.values.toList();
  bool isAlready =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isAlready == true) {
    recentlybox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    recentlybox.deleteAt(index);
    recentlybox.add(value);
  }
}

addToFavorites(int index, Favorite value, BuildContext context) async {
  List<Favorite> favdb = favoritebox.values.toList();
  bool isAlreadyThere =
      favdb.where((element) => element.songname == value.songname).isEmpty;
  if (isAlreadyThere == true) {
    favoritebox.add(value);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text("Added to favorites"),
    ));
  } else {
    int index =
        favdb.indexWhere((element) => element.songname == value.songname);
    favoritebox.deleteAt(index);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text("Removed from favorites"),
    ));
  }
}

bool checkFavoriteStatus(int index, List<Songs> songdb, BuildContext context) {
  Favorite value = Favorite(
      songname: songdb[index].songname,
      artist: songdb[index].artist,
      duration: songdb[index].duration,
      songurl: songdb[index].songurl,
      id: songdb[index].id);
  List<Favorite> favdb = favoritebox.values.toList();
  bool isAlreadyThere =
      favdb.where((element) => element.songname == value.songname).isEmpty;
  return isAlreadyThere ? false : true;
}
