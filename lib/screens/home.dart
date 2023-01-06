import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/HomeScreen/card.dart';
import 'package:firstproject/widgets/HomeScreen/list.dart';
import 'package:firstproject/widgets/HomeScreen/title.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    double vwh = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white.withOpacity(0),
      child: SafeArea(
        child: Scaffold(
          bottomSheet: HomeBottomTile(),
          backgroundColor: mainBgColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeTitle(titletexthome: discover),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HomeCard(
                          cardcolor: homeCard11,
                          iconcolor: homeCard12,
                          cardtitle: playlists,
                          cardicon: Icons.queue_music,
                          pageindex: 0,
                        ),
                        HomeCard(
                          cardcolor: homeCard21,
                          iconcolor: homeCard22,
                          cardtitle: favorites,
                          cardicon: Icons.favorite,
                          pageindex: 1,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HomeCard(
                          cardcolor: homeCard31,
                          iconcolor: homeCard32,
                          cardtitle: most,
                          cardicon: Icons.repeat,
                          pageindex: 2,
                        ),
                        HomeCard(
                          cardcolor: homeCard41,
                          iconcolor: homeCard42,
                          cardtitle: recently,
                          cardicon: Icons.history,
                          pageindex: 3,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: vwh * 0.015, bottom: vwh * 0.015),
                  child: const HomeTitle(titletexthome: allsongs),
                ),
                const HomeMusicTiles(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
