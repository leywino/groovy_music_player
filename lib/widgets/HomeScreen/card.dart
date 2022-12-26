import 'package:firstproject/screens/favorites.dart';
import 'package:firstproject/screens/playlists.dart';
import 'package:firstproject/screens/recently_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard extends StatelessWidget {
  HomeCard({
    super.key,
    this.cardcolor,
    this.iconcolor,
    this.cardicon,
    this.cardtitle,
    this.pageindex,
  });
  final Color? cardcolor;
  final Color? iconcolor;
  final IconData? cardicon;
  final String? cardtitle;
  final int? pageindex;

  final pages = [
    ScreenPlaylists(),
    const ScreenFavorites(),
    const ScreenRecently(),
  ];

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => pages[pageindex!]));
      },
      child: SizedBox(
        width: vww * 0.46,
        height: vwh * 0.08,
        child: Card(
          color: cardcolor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                cardicon,
                size: 25,
                color: iconcolor,
              ),
              Text(
                cardtitle!,
                style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
