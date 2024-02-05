import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/FavoriteScreen/list.dart';
import 'package:firstproject/widgets/FavoriteScreen/title.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';

class ScreenFavorites extends StatelessWidget {
  const ScreenFavorites({super.key, allfavaudio});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0),
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppbar(),
          bottomSheet: HomeBottomTile(),
          backgroundColor: mainBgColor,
          body: const SingleChildScrollView(
            child: Column(
              children: [
                FavoriteTitle(),
                FavoriteLists(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
