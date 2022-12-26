import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/NowPlaying/bar.dart';
import 'package:firstproject/widgets/NowPlaying/buttons.dart';
import 'package:firstproject/widgets/NowPlaying/icon.dart';
import 'package:firstproject/widgets/NowPlaying/info.dart';
import 'package:firstproject/widgets/NowPlaying/nav.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';

class NowPlayingScreen extends StatelessWidget {
  static ValueNotifier<int> spindex = ValueNotifier(spider!);
  static int? spider = 0;

  NowPlayingScreen({super.key, this.intindex, this.opendb});

  final intindex;
  final opendb;

  final box = SongBox.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(),
        backgroundColor: mainBgColor,
        body: ValueListenableBuilder(
            valueListenable: spindex,
            builder: (context, int spider, child) {
              return Column(
                children: [
                  NPIcon(intindex: spider,opendb: opendb),
                  NPInfo(intindex: spider,opendb: opendb),
                  NPBar(),
                  NPButtons(intindex: spider),
                  NPNav(),
                ],
              );
            }));
  }
}
