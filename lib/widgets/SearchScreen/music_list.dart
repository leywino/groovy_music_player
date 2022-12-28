import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchList extends StatefulWidget {
  SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

final songbox = SongBox.getInstance();

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    List<Songs> songdb = songbox.values.toList();
    double vww = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: songdb.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => NowPlayingScreen(intindex: index),
              ),
            );
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: QueryArtworkWidget(
              artworkBorder: BorderRadius.circular(8),
              keepOldArtwork: true,
              id: songdb[index].id!,
              type: ArtworkType.AUDIO,
            ),
          ),
          title: Text(
            songdb[index].songname!,
            style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(bottom: vww * 0.035),
            child: Text(
              songdb[index].artist!,
              style: GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
            ),
          ),
          trailing: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: vww * 0.035),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Colors.white,
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
  }
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
