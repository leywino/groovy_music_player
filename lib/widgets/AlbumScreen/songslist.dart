import 'package:firstproject/screens/nowplaying.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbumSongList extends StatelessWidget {
  AlbumSongList({super.key, required this.intindex});

  final intindex;
  final title = [
    'Without Me',
    'Attention',
    'History',
    'Jocelyn Flores',
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
    double vwh = MediaQuery.of(context).size.height;
    double vww = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mainBgColor,
      appBar: CustomAppbar(),
      body: Padding(
        padding: EdgeInsets.only(top: vwh * 0.03),
        child: ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
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
                  child: Image.asset(images[intindex]),
                ),
                title: Text(
                  title[intindex],
                  style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(bottom: vww * 0.035),
                  child: Text(
                    artists[intindex],
                    style: GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
                  ),
                ),
                // trailing: Wrap(
                //   children: [
                //     IconButton(
                //       onPressed: () {},
                //       icon: Icon(
                //         Icons.delete,
                //         color: Colors.red,
                //         size: 25,
                //       ),
                //     ),
                //   ],
                // ),
              );
            })),
      ),
    );
  }
}
