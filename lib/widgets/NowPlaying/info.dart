import 'package:firstproject/database/song_model.dart';
import 'package:flutter/material.dart';

class NPInfo extends StatelessWidget {
  NPInfo({super.key, this.intindex});

  final intindex;

  @override
  Widget build(BuildContext context) {
    final box = SongBox.getInstance();
    List<Songs> songdb = box.values.toList();
    double vww = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: vww * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  songdb[intindex].songname!,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Text(
                  songdb[intindex].artist!,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
