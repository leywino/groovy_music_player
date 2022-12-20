import 'package:firstproject/screens/now_playing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteLists extends StatefulWidget {
  const FavoriteLists({super.key});

  @override
  State<FavoriteLists> createState() => _FavoriteListsState();
}

class _FavoriteListsState extends State<FavoriteLists> {
  final title = [
    'Without Me',
    'Jocelyn Flores',
    'History',
  ];
  final artist = [
    'Halsey',
    'XXXTENTACICON',
    'One Direction',
  ];
  final images = [
    'assets/images/withoutme.jpg',
    'assets/images/jocelyn.jpg',
    'assets/images/history.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: title.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => NowPlayingScreen(
                  intindex: index,
                ),
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
          trailing: Padding(
            padding: EdgeInsets.only(bottom: vww * 0.035),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 25,
              ),
            ),
          ),
        );
      },
    );
  }
}
