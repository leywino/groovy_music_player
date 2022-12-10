import 'package:firstproject/screens/albums.dart';
import 'package:firstproject/screens/favorites.dart';
import 'package:firstproject/screens/playlists.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard1 extends StatelessWidget {
  HomeCard1({
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
    const ScreenPlaylists(),
    const ScreenFavorites(),
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
        width: vww * 0.3,
        height: vwh * 0.17,
        child: Card(
          color: cardcolor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                cardicon,
                size: 60,
                color: iconcolor,
              ),
              Text(
                cardtitle!,
                style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontSize: 20,
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
