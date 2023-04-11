import 'package:firstproject/database/most_played_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  // reqStoragePerm() async {
  @override
  Widget build(BuildContext context) {
    navigateToHome(context);
    return Container(
      color: Colors.white.withOpacity(0),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: mainBgColor,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/splash.png', height: 150),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final audioquery = OnAudioQuery();
final box = SongBox.getInstance();
final mostbox = MostBox.getInstance();
List<SongModel> allSongs = [];
List<SongModel> getSongs = [];

navigateToHome(BuildContext ctx) async {
  bool permissionStatus = await audioquery.permissionsStatus();
  if (!permissionStatus) {
    await audioquery.permissionsRequest();
  }
  getSongs = await audioquery.querySongs();
  for (var element in getSongs) {
    if (element.fileExtension == "mp3") {
      allSongs.add(element);
    }
  }
  for (var element in allSongs) {
    mostbox.add(
      Most(
          songname: element.title,
          artist: element.artist!,
          duration: element.duration!,
          id: element.id,
          songurl: element.uri!,
          count: 1),
    );
  }
  if (box.isEmpty) {
    for (var element in allSongs) {
      box.add(Songs(
        songname: element.title,
        artist: element.artist,
        duration: element.duration,
        id: element.id,
        songurl: element.uri,
      ));
    }
  }
  await Future.delayed(
    const Duration(milliseconds: 1500),
    () {
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => NavBarBottom(
            selectedIndex: 0,
            allSongs: allSongs,
          ),
        ),
      );
    },
  );
}
