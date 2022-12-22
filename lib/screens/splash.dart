import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/widgets/HomeScreen/list.dart';
import 'package:firstproject/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

final audioquery = OnAudioQuery();
final box = SongBox.getInstance();
List<SongModel> allSongs = [];
List<SongModel> getSongs = [];

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    requestStoragePermission();
    navigateToHome(context);
    super.initState();
  }

  requestStoragePermission() async {
    bool permissionStatus = await audioquery.permissionsStatus();
    if (!permissionStatus) {
      await audioquery.permissionsRequest();

      getSongs = await audioquery.querySongs();
      for (var element in getSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }

      for (var element in allSongs) {
        await box.add(Songs(
          songname: element.title,
          artist: element.artist,
          duration: element.duration,
          id: element.id,
          songurl: element.uri,
        ));
      }
      List<Songs> songsdb = box.values.toList();
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 80),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

navigateToHome(BuildContext ctx) async {
  await Future.delayed(
    const Duration(milliseconds: 1500),
    () {
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => NavBarBottom(selectedIndex: 0),
        ),
      );
    },
  );
}
