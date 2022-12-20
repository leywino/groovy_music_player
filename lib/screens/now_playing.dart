import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/NowPlaying/bar.dart';
import 'package:firstproject/widgets/NowPlaying/buttons.dart';
import 'package:firstproject/widgets/NowPlaying/icon.dart';
import 'package:firstproject/widgets/NowPlaying/info.dart';
import 'package:firstproject/widgets/NowPlaying/nav.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';

class NowPlayingScreen extends StatelessWidget {
  NowPlayingScreen({super.key, this.intindex});

  final intindex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: mainBgColor,
      body: Column(
        children: [
          NPIcon(intindex: intindex),
          NPInfo(intindex: intindex),
          NPBar(),
          NPButtons(intindex: intindex),
          NPNav(),
        ],
      ),
    );
  }
}
