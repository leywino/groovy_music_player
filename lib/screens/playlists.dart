import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:firstproject/widgets/PlaylistScreen/list.dart';
import 'package:firstproject/widgets/PlaylistScreen/title.dart';
import 'package:flutter/material.dart';

class ScreenPlaylists extends StatelessWidget {
  const ScreenPlaylists({super.key});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      bottomSheet: HomeBottomTile(),
      appBar: const CustomAppbar(),
      body: Column(
        children: const [
          PlaylistTitle(),
          PlaylistList(),
        ],
      ),
    );
  }
}
