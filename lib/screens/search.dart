import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/SearchScreen/list.dart';
import 'package:flutter/material.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: HomeBottomTile(),
        backgroundColor: mainBgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchList(),
            ],
          ),
        ),
      ),
    );
  }
}
