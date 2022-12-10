import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/FavoriteScreen/list.dart';
import 'package:firstproject/widgets/FavoriteScreen/title.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';

class ScreenFavorites extends StatelessWidget {
  const ScreenFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      backgroundColor: mainBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FavoriteTitle(),
            const FavoriteLists(),
          ],
        ),
      ),
    );
  }
}
