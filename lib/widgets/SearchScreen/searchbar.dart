import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  SearchBar({super.key, required this.searchController});

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
      child: SizedBox(
        height: vww * 0.15,
        child: TextField(
          style: GoogleFonts.rubik(color: Colors.white),
          controller: searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 5),
            fillColor: Colors.black,
            filled: true,
            suffixIcon: IconButton(
              onPressed: () {
                clearText();
              },
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15),
              child: Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 35,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide.none,
            ),
            hintText: 'Search',
            hintStyle: GoogleFonts.rubik(color: Colors.grey, fontSize: 20),
          ),
        ),
      ),
    );
  }

  void clearText() {
    searchController.clear();
  }
}
