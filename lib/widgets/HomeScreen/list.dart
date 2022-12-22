import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeMusicTiles extends StatefulWidget {
  HomeMusicTiles({super.key});

  @override
  State<HomeMusicTiles> createState() => _HomeMusicTilesState();
}

class _HomeMusicTilesState extends State<HomeMusicTiles> {
  final box = SongBox.getInstance();
  bool favcolor = true;
  @override
  void initState() {
    List<Songs> songs = box.values.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;

    return ValueListenableBuilder<Box<Songs>>(
      valueListenable: box.listenable(),
      builder: ((context, Box<Songs> allsongbox, child) {
        List<Songs> songsdb = allsongbox.values.toList();
        final List<bool> selected = List.generate(songsdb.length, (i) => false);
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
              onTap: () {
                HomeBottomTile.vindex.value = index;
                NowPlayingScreen.spindex.value = index;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => NowPlayingScreen(
                      intindex: index,
                      songs: songs,
                      songdb: songsdb,
                    ),
                  ),
                );
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: vww * 0.035),
                    child: IconButton(
                      onPressed: () {
                        setState(() => selected[index] = !selected[index]);
                      },
                      icon: Icon(
                        selected[index]
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: selected[index] ? Colors.pink : Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showOptions(context);
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

  showOptions(BuildContext context) {
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
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_outline,
                  size: 30,
                  color: Colors.white,
                ),
                label: Text(
                  'Add to Favorites',
                  style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.playlist_add,
                  size: 30,
                  color: Colors.white,
                ),
                label: Text(
                  'Add to Playlist',
                  style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
