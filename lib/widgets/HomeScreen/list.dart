import 'package:firstproject/screens/nowplaying.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMusicTiles extends StatefulWidget {
  const HomeMusicTiles({super.key});

  @override
  State<HomeMusicTiles> createState() => _HomeMusicTilesState();
}

class _HomeMusicTilesState extends State<HomeMusicTiles> {
  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => NowPlayingScreen(),
              ),
            );
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("assets/images/tileicon.jpg"),
          ),
          title: Text(
            'Without Me',
            style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(bottom: vww * 0.035),
            child: Text(
              'Halsey',
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
