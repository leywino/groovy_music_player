import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/MostPlayed/list.dart';
import 'package:firstproject/widgets/MostPlayed/title.dart';
import 'package:firstproject/widgets/PlaylistScreen/appbar.dart';
import 'package:flutter/material.dart';

class ScreenMosts extends StatelessWidget {
  const ScreenMosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      backgroundColor: mainBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MostTitle(),
            const MostLists(),
          ],
        ),
      ),
    );
  }
}
