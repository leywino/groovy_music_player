import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/SearchScreen/searchbar.dart';
import 'package:flutter/material.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBgColor,
        body: Column(
          children: [
            SearchBar(
              searchController: _searchController,
            ),
          ],
        ),
      ),
    );
  }
}
