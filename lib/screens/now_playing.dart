import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/NowPlaying/bar.dart';
import 'package:firstproject/widgets/NowPlaying/buttons.dart';
import 'package:firstproject/widgets/NowPlaying/icon.dart';
import 'package:firstproject/widgets/NowPlaying/info.dart';
import 'package:firstproject/widgets/NowPlaying/nav.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NowPlayingScreen extends StatelessWidget {
  static ValueNotifier<int> spindex = ValueNotifier(spider!);
  static int? spider = 0;

  NowPlayingScreen({super.key, this.intindex, this.opendb});

  int? intindex;
  dynamic opendb;

  final box = SongBox.getInstance();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0),
      child: SafeArea(
        child: Scaffold(
            appBar: const CustomAppbar(),
            backgroundColor: mainBgColor,
            body: ValueListenableBuilder(
                valueListenable: spindex,
                builder: (context, int spider, child) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        NPIcon(intindex: intindex, opendb: opendb),
                        NPInfo(intindex: intindex, opendb: opendb),
                        const NPBar(),
                        NPButtons(intindex: spider),
                        const NPNav(),
                      ],
                    ),
                  );
                })),
      ),
    );
  }
}
