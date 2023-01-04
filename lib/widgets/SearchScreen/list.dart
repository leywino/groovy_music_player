import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/FavoriteScreen/list.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key});
  @override
  State<SearchList> createState() => _SearchListState();
}

final songbox = SongBox.getInstance();

List<Songs>? searchsongsdb = songbox.values.toList();
List<Audio> allsongs = [];
var searchController = TextEditingController();

class _SearchListState extends State<SearchList> {
  @override
  void initState() {
    searchsongsdb = songbox.values.toList();
    super.initState();
  }

  List<Songs> searchlist = List.from(searchsongsdb!);

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          child: SizedBox(
            height: vww * 0.15,
            child: TextFormField(
              onSaved: (value) => setState(() {
                updateSearch(value!);
              }),
              onChanged: (value) => setState(() {
                updateSearch(value);
              }),
              style: GoogleFonts.rubik(color: Colors.white),
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 5),
                fillColor: Colors.black,
                filled: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    clearText();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 15),
                  child: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                hintStyle: GoogleFonts.rubik(color: Colors.grey, fontSize: 20),
              ),
            ),
          ),
        ),
        searchlist.isEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: vww * 0.03),
                child: Row(
                  children: const [
                    Text(
                      'No songs found',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: searchlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      player.open(Playlist(audios: allsongs, startIndex: index),
                          showNotification: notificationBool,
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          loopMode: LoopMode.playlist);
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => NowPlayingScreen(),
                        ),
                      );
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(8),
                        keepOldArtwork: true,
                        id: searchlist[index].id!,
                        type: ArtworkType.AUDIO,
                      ),
                    ),
                    title: Text(
                      searchlist[index].songname!,
                      style:
                          GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(bottom: vww * 0.035),
                      child: Text(
                        searchlist[index].artist!,
                        style:
                            GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            showOptions(context);
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
              ),
      ],
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
                icon: const Icon(
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
                icon: const Icon(
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

  void updateSearch(String value) {
    List<Songs> songssdb = songbox.values.toList();
    setState(() {
      if (value.isEmpty) {
        searchlist = songssdb;
      }
      searchlist = searchsongsdb!
          .where((element) =>
              element.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      allsongs.clear();
      for (var item in searchlist) {
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
    });
  }
}

void clearText() {
  searchController.clear();
}
