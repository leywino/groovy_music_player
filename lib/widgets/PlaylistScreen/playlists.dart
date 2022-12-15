import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/title.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayListOne extends StatelessWidget {
  const PlayListOne({super.key});

  @override
  Widget build(BuildContext context) {
    double vwh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppbar(),
      backgroundColor: mainBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: vwh * 0.02,
                bottom: vwh * 0.02,
              ),
              child: HomeTitle(titletexthome: 'Playlist 1'),
            ),
            PlaylISTLIST1(),
          ],
        ),
      ),
    );
  }
}

class PlayListTwo extends StatelessWidget {
  const PlayListTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      backgroundColor: mainBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: HomeTitle(titletexthome: 'Playlist 2'),
            ),
            PlaylISTLIST2(),
          ],
        ),
      ),
    );
  }
}

class PlaylISTLIST1 extends StatelessWidget {
  PlaylISTLIST1({super.key});
  final title = [
    'Older',
    'I\'m Good',
    'Attention',
    'Everything Black',
  ];
  final artist = [
    'Sasha Alex Sloan',
    'David Guetta, Bebe Rexha',
    'Charlie Puth',
    'Unlike Pluto, Mike Taylor',
  ];
  final images = [
    'assets/images/older.jpg',
    'assets/images/imgood.jpg',
    'assets/images/attention.jpg',
    'assets/images/everything.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: title.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return ListTile(
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

class PlaylISTLIST2 extends StatelessWidget {
  PlaylISTLIST2({super.key});
  final title = [
    'Attention',
    'Everything Black',
  ];
  final artist = [
    'Charlie Puth',
    'Unlike Pluto, Mike Taylor',
  ];
  final images = [
    'assets/images/attention.jpg',
    'assets/images/everything.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: title.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return ListTile(
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
