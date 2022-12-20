import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/HomeScreen/bottom_tile.dart';
import 'package:firstproject/widgets/SearchScreen/music_list.dart';
import 'package:firstproject/widgets/SearchScreen/search_bar.dart';
import 'package:flutter/material.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: HomeBottomTile(),
        backgroundColor: mainBgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchBar(
                searchController: _searchController,
              ),
              SearchList(),
            ],
          ),
        ),
      ),
    );
  }
}
