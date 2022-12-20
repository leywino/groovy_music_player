import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchList extends StatefulWidget {
  SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final title = [
    'Without Me',
    'Jocelyn Flores',
    'History',
    'Happier',
    'Everything Black',
    'Older',
    'I\'m Good',
    'Attention',
  ];
  final artist = [
    'Halsey',
    'XXXTENTACICON',
    'One Direction',
    'Marshmello',
    'Unlike Pluto, Mike Taylor',
    'Sasha Alex Sloan',
    'David Guetta, Bebe Rexha',
    'Charlie Puth',
  ];
  final images = [
    'assets/images/withoutme.jpg',
    'assets/images/jocelyn.jpg',
    'assets/images/history.jpg',
    'assets/images/happier.jpg',
    'assets/images/everything.jpg',
    'assets/images/older.jpg',
    'assets/images/imgood.jpg',
    'assets/images/attention.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: title.length,
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
            child: Image.asset(images[index]),
          ),
          title: Text(
            title[index],
            style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(bottom: vww * 0.035),
            child: Text(
              artist[index],
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
