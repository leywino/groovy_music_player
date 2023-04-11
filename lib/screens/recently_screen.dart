import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:firstproject/widgets/RecentlyPlayed/list.dart';
import 'package:firstproject/widgets/RecentlyPlayed/title.dart';
import 'package:flutter/material.dart';

class ScreenRecently extends StatelessWidget {
  const ScreenRecently({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0),
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppbar(),
          backgroundColor: mainBgColor,
          bottomSheet: HomeBottomTile(),
          body: SingleChildScrollView(
            child: Column(
              children:  [
                const RecentlyTitle(),
                RecentlyList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
