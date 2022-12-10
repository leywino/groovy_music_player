import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/AlbumScreen/list.dart';
import 'package:firstproject/widgets/AlbumScreen/title.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScreenAlbums extends StatelessWidget {
  const ScreenAlbums({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: mainBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AlbumTiles(),
            AlbumLists(),
          ],
        ),
      ),
    );
  }
}
