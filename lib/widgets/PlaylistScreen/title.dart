import 'package:firstproject/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistTitle extends StatelessWidget {
  const PlaylistTitle({super.key});

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: vww * 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(
                Icons.queue_music,
                color: homeCard12,
                size: 45,
              ),
              Text(
                'Playlists',
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
