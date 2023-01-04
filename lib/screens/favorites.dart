import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/FavoriteScreen/list.dart';
import 'package:firstproject/widgets/FavoriteScreen/title.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';

class ScreenFavorites extends StatelessWidget {
  const ScreenFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      bottomSheet: HomeBottomTile(),
      backgroundColor: mainBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            FavoriteTitle(),
            FavoriteLists(),
          ],
        ),
      ),
    );
  }
}
