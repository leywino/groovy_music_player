import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/favorite_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteLists extends StatefulWidget {
  const FavoriteLists({super.key});

  @override
  State<FavoriteLists> createState() => _FavoriteListsState();
}

final favoritebox = FavoriteBox.getInstance();
final player = AssetsAudioPlayer.withId('key');
List<Favorite> favsongslist = [];
List<Audio> allsongs = [];

class _FavoriteListsState extends State<FavoriteLists> {
  @override
  void initState() {
    final favSongsdb = favoritebox.values.toList();
    for (var item in favSongsdb) {
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

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<Box<Favorite>>(
      valueListenable: favoritebox.listenable(),
      builder: (context, Box<Favorite> allfavsongs, child) {
        List<Favorite> favdb = allfavsongs.values.toList();
        return favdb.isEmpty
            ? Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: vww * 0.05),
                    child: const Text(
                      'You have no favorite songs!',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: favdb.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => NowPlayingScreen(
                            intindex: index,
                            opendb: favdb,
                          ),
                        ),
                      );
                      player.open(Playlist(audios: allsongs, startIndex: index),
                          showNotification: notificationBool,
                          headPhoneStrategy:
                              HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                          loopMode: LoopMode.playlist);
                      player.play();
                      await player.open(
                        Audio.file(favdb[index].songurl!),
                        showNotification: notificationBool,
                        playInBackground: PlayInBackground.disabledPause,
                        audioFocusStrategy: const AudioFocusStrategy.request(
                          resumeAfterInterruption: true,
                          resumeOthersPlayersAfterDone: true,
                        ),
                      );
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(8),
                        keepOldArtwork: true,
                        id: favdb[index].id!,
                        type: ArtworkType.AUDIO,
                      ),
                    ),
                    title: Text(
                      favdb[index].songname!,
                      style:
                          GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(bottom: vww * 0.035),
                      child: Text(
                        favdb[index].artist!,
                        style:
                            GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.only(bottom: vww * 0.035),
                      child: IconButton(
                        onPressed: () {
                          favoritebox.deleteAt(index);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            content: Text("Removed from favorites"),
                          ));
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
      },
    );
  }
}

bool checkIndexSkip(int intindex, List<Favorite> favdb) {
  return (intindex < favdb.length - 1) ? false : true;
}

bool checkIndexPrev(int intindex, List<Favorite> favdb) {
  return (intindex <= 0) ? true : false;
}
