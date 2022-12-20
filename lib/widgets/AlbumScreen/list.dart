import 'package:firstproject/widgets/AlbumScreen/song_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbumLists extends StatefulWidget {
  const AlbumLists({super.key});

  @override
  State<AlbumLists> createState() => _AlbumListsState();
}

class _AlbumListsState extends State<AlbumLists> {
  final title = [
    'Voicenotes ',
    'Made In The A.M. (Deluxe Edition)',
    '17',
    'Without Me (With Juice World)',
    'Happier',
    'I\'m Good (Blue)',
  ];
  final images = [
    'assets/images/attention.jpg',
    'assets/images/history.jpg',
    'assets/images/jocelyn.jpg',
    'assets/images/withoutme.jpg',
    'assets/images/happier.jpg',
    'assets/images/imgood.jpg',
  ];
  final artists = [
    'Charlie Puth',
    'One Direction',
    'XXXTENTACION',
    'Halsey',
    'Marshmello',
    'David Guetta, Bebe Rexha',
  ];

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: vww * 0.055),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: vww * 0.03,
          mainAxisSpacing: vww * 0.03,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: title.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => AlbumSongList(intindex: index),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: vww * 0.4,
                      child: Image.asset(images[index]),
                    ),
                  ),
                  Text(
                    title[index],
                    style: GoogleFonts.rubik(color: Colors.white, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
