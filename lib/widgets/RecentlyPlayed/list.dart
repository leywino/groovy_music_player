import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyList2 extends StatefulWidget {
  const RecentlyList2({super.key});

  @override
  State<RecentlyList2> createState() => _RecentlyList2State();
}

class _RecentlyList2State extends State<RecentlyList2> {
  final player = AssetsAudioPlayer.withId('key');

  final List<Recently> recentplay = [];
  final box = RecentlyBox.getInstance();
  List<Audio> recentplayedaudio = [];
  @override
  void initState() {
    final List<Recently> recentdb = box.values.toList();
    for (var item in recentdb) {
      recentplayedaudio.add(
        Audio.file(
          item.songurl.toString(),
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          ),
        ),
      );
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Recently>>(
      valueListenable: box.listenable(),
      builder: ((context, Box<Recently> recentDB, child) {
        double vww = MediaQuery.of(context).size.width;
        // double vwh = MediaQuery.of(context).size.height;
        List<Recently> recentdb = recentDB.values.toList();
        return recentdb.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: vww * 0.05),
                    child: const Text(
                      'You have no recently played songs!',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recentdb.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(8),
                        keepOldArtwork: true,
                        id: recentdb[index].id!,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            'assets/images/music.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      recentdb[index].songname!,
                      style:
                          GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(bottom: vww * 0.035),
                      child: Text(
                        recentdb[index].artist!,
                        style:
                            GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    onTap: () {
                      player.open(
                          Playlist(
                              audios: recentplayedaudio, startIndex: index),
                          showNotification: true,
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          loopMode: LoopMode.playlist);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => NowPlayingScreen(
                            intindex: index,
                            opendb: recentdb,
                          ),
                        ),
                      );
                    },
                  );
                }),
              );
      }),
    );
  }
}
