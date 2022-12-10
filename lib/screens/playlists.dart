import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:firstproject/widgets/PlaylistScreen/list.dart';
import 'package:firstproject/widgets/PlaylistScreen/title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenPlaylists extends StatelessWidget {
  const ScreenPlaylists({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      appBar: CustomAppbar(),
      body: Column(
        children: [
          PlaylistTitle(),
          PlaylistList(),
        ],
      ),
    );
  }
}
