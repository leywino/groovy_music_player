import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/NowPlaying/icon.dart';
import 'package:firstproject/widgets/NowPlaying/info.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: mainBgColor,
      body: Column(
        children: [
          NPIcon(),
          NPInfo(),
        ],
      ),
    );
  }
}
