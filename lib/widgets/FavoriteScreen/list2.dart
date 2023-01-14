import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/favorite_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/FavoriteScreen/list.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteLists2 extends StatefulWidget {
  const FavoriteLists2({super.key});

  @override
  State<FavoriteLists2> createState() => _FavoriteLists2State();
}

List<Audio> allsongs = [];
final audioPlayer = AssetsAudioPlayer.withId('key');

class _FavoriteLists2State extends State<FavoriteLists2> {
  @override
  void initState() {
    final List<Favorite> favouritesongs = favoritebox.values.toList();
    for (var item in favouritesongs) {
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
      setState(() {});
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoritebox = FavoriteBox.getInstance();
    return ValueListenableBuilder<Box<Favorite>>(
      valueListenable: favoritebox.listenable(),
      builder: ((context, Box<Favorite> alldbfavsongs, child) {
        List<Favorite> allDbsongs = alldbfavsongs.values.toList();
        if (favoritebox.isEmpty) {
          return const Center(
            child: Text(
              "No Favourites",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          );
        }
        // ignore: unnecessary_null_comparison
        if (favoritebox == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: allDbsongs.length,
          padding: const EdgeInsets.only(top: 10),
          itemBuilder: (context, index) {
            return ListTile(
                onTap: (() {
                  audioPlayer.open(
                      Playlist(audios: allsongs, startIndex: index),
                      showNotification: notificationBool,
                      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                      loopMode: LoopMode.playlist);
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => NowPlayingScreen(
                        intindex: index,
                        opendb: allDbsongs,
                      ),
                    ),
                  );
                }),
                leading: QueryArtworkWidget(
                  artworkHeight: 55,
                  artworkWidth: 55,
                  id: allDbsongs[index].id!,
                  type: ArtworkType.AUDIO,
                  artworkFit: BoxFit.cover,
                  size: 200,
                  quality: 100,
                  artworkBorder: BorderRadius.circular(10),
                  nullArtworkWidget: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      'assets/images/music.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 50, 50, 50),
                              title: const Text(
                                "Remove from favourites",
                                style: TextStyle(color: Colors.white),
                              ),
                              content: const Text("Are you Sure ?",
                                  style: TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 213, 213, 213))),
                                ),
                                TextButton(
                                    onPressed: () {
                                      favoritebox.deleteAt(index);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Remove",
                                        style: TextStyle(
                                            color: (Color.fromARGB(
                                                255, 213, 213, 213))))),
                              ],
                            );
                          }));
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.grey,
                    )),
                subtitle: Text(
                  allDbsongs[index].artist!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Inter",
                  ),
                ),
                title: Text(
                  allDbsongs[index].songname!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold),
                ));
          },
        );
      }),
    );
  }
}
