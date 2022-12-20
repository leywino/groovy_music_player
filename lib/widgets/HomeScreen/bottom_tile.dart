import 'package:firstproject/screens/now_playing.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomeBottomTile extends StatefulWidget {
  HomeBottomTile({super.key});

  @override
  State<HomeBottomTile> createState() => _HomeBottomTileState();
}

class _HomeBottomTileState extends State<HomeBottomTile> {
  int intindex = 0;

  

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

  final images = [
    'assets/images/withoutme.jpg',
    'assets/images/jocelyn.jpg',
    'assets/images/history.jpg',
    'assets/images/happier.jpg',
    'assets/images/everything.jpg',
    'assets/images/older.jpg',
    'assets/images/imgood.jpg',
    'assets/images/attention.jpg',
  ];

  final player = AudioPlayer();
  bool pauseplay = true;
  final songs = [
    'assets/songs/Without_Me__with_Juice_WRLD_.mp3',
    'assets/songs/Jocelyn_Flores.mp3',
    'assets/songs/History.mp3',
    'assets/songs/Happier.mp3',
    'assets/songs/Everything_Black.mp3',
    'assets/songs/Older.mp3',
    'assets/songs/I_m_Good__Blue_.mp3',
    'assets/songs/Attention.mp3',
  ];

  

  @override
  Widget build(BuildContext context) {
    double vwh = MediaQuery.of(context).size.height;
    double vww = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: vww * 0.02, right: vww * 0.02),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => NowPlayingScreen(
                intindex: intindex,
              ),
            ),
          );
        },
        child: Container(
          height: vwh * 0.1,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: vwh * 0.014,
                ),
                child: Wrap(
                  spacing: vww * 0.02,
                  children: [
                    SizedBox(
                      width: vwh * 0.075,
                      height: vwh * 0.075,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(images[intindex]),
                      ),
                    ),
                    SizedBox(
                      width: vww * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title[intindex],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            artist[intindex],
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: vwh * 0.014,
                ),
                child: Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          intindex--;
                        });
                      },
                      child: Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          pauseplay = !pauseplay;
                        });
                        playMusic();
                      },
                      child: Icon(
                        pauseplay
                            ? Icons.play_circle_fill
                            : Icons.pause_circle_filled,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          intindex++;
                        });
                      },
                      child: Icon(
                        Icons.skip_next,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  playMusic() async {
    if (!pauseplay) {
      final duration = await player.setUrl('asset:${songs[intindex]}');
      player.play();
    } else {
      player.pause();
    }
  }
}
