import 'package:flutter/material.dart';

class NPInfo extends StatelessWidget {
  NPInfo({super.key, this.intindex});

  final intindex;

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

  @override
  Widget build(BuildContext context) {
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
                  title[intindex],
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Text(
                  artist[intindex],
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
