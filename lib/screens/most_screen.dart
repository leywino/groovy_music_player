import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/MostPlayed/list.dart';
import 'package:firstproject/widgets/MostPlayed/title.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';

class ScreenMosts extends StatefulWidget {
  const ScreenMosts({super.key});

  @override
  State<ScreenMosts> createState() => _ScreenMostsState();
}

class _ScreenMostsState extends State<ScreenMosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      bottomSheet: HomeBottomTile(),
      backgroundColor: mainBgColor,
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const MostTitle(),
            const MostLists(),
          ],
        ),
      ),
    );
  }
}
