import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/homecard1.dart';
import 'package:firstproject/widgets/HomeScreen/homecard2.dart';
import 'package:firstproject/widgets/HomeScreen/homemusictile.dart';
import 'package:firstproject/widgets/HomeScreen/hometitle.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    double vwh = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBgColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: vwh * 0.1, bottom: vwh * 0.015),
                child: const HomeTitle(titletexthome: 'Discover'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  HomeCard1(
                    cardcolor: homeCard11,
                    iconcolor: homeCard12,
                    cardtitle: 'Playlists',
                    cardicon: Icons.queue_music,
                    pageindex: 0,
                  ),
                  HomeCard1(
                    cardcolor: homeCard21,
                    iconcolor: homeCard22,
                    cardtitle: 'Favorites',
                    cardicon: Icons.favorite,
                    pageindex: 1,
                  ),
                  HomeCard2(
                    cardcolor: homeCard31,
                    cardtitle: 'Album',
                    pageindex: 0,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: vwh * 0.015, bottom: vwh * 0.015),
                child: const HomeTitle(titletexthome: 'All Songs'),
              ),
              HomeMusicTiles(),
            ],
          ),
        ),
      ),
    );
  }
}
