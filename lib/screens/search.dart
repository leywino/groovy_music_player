import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/SearchScreen/list.dart';
import 'package:flutter/material.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white.withOpacity(0),
        child: SafeArea(
          child: Scaffold(
            bottomSheet: HomeBottomTile(),
            backgroundColor: mainBgColor,
            body: const SingleChildScrollView(
              child: Column(
                children: [
                  SearchList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
