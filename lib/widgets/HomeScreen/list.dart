import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/favorite_model.dart';
import 'package:firstproject/database/most_played_model.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/add_to_playlist.dart';
import 'package:firstproject/widgets/functions.dart';
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
final mostbox = MostBox.getInstance();

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
                // Most mostsongs = Most(
                //     songname: songsdb[index].songname,
                //     artist: songsdb[index].artist,
                //     duration: songsdb[index].duration,
                //     songurl: songsdb[index].songurl,
                //     id: songsdb[index].id);

                // checkMostPlayed(mostsongs, index);
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
