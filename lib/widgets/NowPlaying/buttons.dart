import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class NPButtons extends StatefulWidget {
  NPButtons({super.key, required this.intindex});

  int intindex = HomeBottomTile.intindex;
  Duration duration = Duration();
  Duration position = Duration();

  @override
  State<NPButtons> createState() => _NPButtonsState();
}

class _NPButtonsState extends State<NPButtons> {
  final player = AudioPlayer();
  bool pauseplay = true;
  @override
  Widget build(BuildContext context) {
    final box = SongBox.getInstance();
    List<Songs> songdb = box.values.toList();
    double vwh = MediaQuery.of(context).size.height;
    double vww = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Slider(
          min: Duration(microseconds: 0).inMinutes.toDouble(),
          value: widget.position.inMinutes.toDouble(),
          max: widget.duration.inMinutes.toDouble(),
          onChanged: (value) {
            setState(() {
              changeToSeconds(value.toInt(), player);
              value = value;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: vww * 0.05, right: vww * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.position.toString().split('.')[0],
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                widget.duration.toString().split('.')[0],
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 20,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.repeat,
                color: Colors.white,
                size: 35,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (pauseplay) {
                  setState(() {
                    pauseplay = !pauseplay;
                  });
                }
                previousMusic(pauseplay, player, songdb, widget.intindex);
              },
              child: Icon(
                Icons.skip_previous,
                color: Colors.white,
                size: 35,
              ),
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  pauseplay = !pauseplay;
                });
                playMusic(pauseplay, player, songdb, widget.intindex);
                setState(() {
                  widget.duration;
                  widget.position;
                });
              },
              child: Icon(
                !pauseplay
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                color: Colors.white,
                size: 60,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (pauseplay) {
                  setState(() {
                    pauseplay = !pauseplay;
                  });
                }
                skipMusic(pauseplay, player, songdb, widget.intindex);
              },
              child: Icon(
                Icons.skip_next,
                color: Colors.white,
                size: 35,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.playlist_add,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ],
    );
  }

  playMusic(bool isPlaying, AudioPlayer player, List<Songs> songdb,
      int intindex) async {
    if (!isPlaying) {
      await player.setAudioSource(
          AudioSource.uri(Uri.parse(songdb[intindex].songurl!)));

      await player.play();
    } else {
      await player.pause();
    }
    if (isPlaying) {
      HomeBottomTile.isPlay.value = true;
    }
    player.durationStream.listen((d) {
      setState(() {
        widget.duration = d!;
        widget.duration;
      });
    });
    player.positionStream.listen((p) {
      setState(() {
        widget.position = p;
        widget.position;
      });
    });
  }
}

skipMusic(bool isPlaying, AudioPlayer player, List<Songs> songdb,
    int intindex) async {
  if (!isPlaying) {
    await player.stop();
  }
  intindex++;
  NowPlayingScreen.spindex.value++;
  HomeBottomTile.vindex.value++;

  await player
      .setAudioSource(AudioSource.uri(Uri.parse(songdb[intindex].songurl!)));
  await player.play();
}

previousMusic(bool isPlaying, AudioPlayer player, List<Songs> songdb,
    int intindex) async {
  if (!isPlaying) {
    await player.stop();
  }

  intindex--;
  NowPlayingScreen.spindex.value--;
  HomeBottomTile.vindex.value--;

  await player
      .setAudioSource(AudioSource.uri(Uri.parse(songdb[intindex].songurl!)));
  await player.play();
}

void changeToSeconds(int seconds, AudioPlayer player) {
  Duration duration = Duration(seconds: seconds);
  player.seek(duration);
}
