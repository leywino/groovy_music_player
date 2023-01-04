import 'package:firstproject/screens/home.dart';
import 'package:firstproject/screens/search.dart';
import 'package:firstproject/screens/settings.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class NavBarBottom extends StatefulWidget {
  NavBarBottom({super.key, this.songlength, required this.selectedIndex});
  int? songlength;
  int? selectedIndex;
  @override
  State<NavBarBottom> createState() => _NavBarBottomState();
}

class _NavBarBottomState extends State<NavBarBottom> {
  final _pages = [
    const ScreenHome(),
    const ScreenSearch(),
    const ScreenSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.selectedIndex != 1
          ? IndexedStack(
              index: widget.selectedIndex,
              children: _pages,
            )
          : _pages[1],
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: navbarcolor1,
        selectedIndex: widget.selectedIndex ?? 0,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          widget.selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            activeColor: navbarcolor2,
            inactiveColor: navbarcolor3,
            icon: const Icon(
              Icons.home,
              size: 25,
            ),
            title: Text(
              'Home',
              style: GoogleFonts.rubik(fontSize: 18),
            ),
          ),
          FlashyTabBarItem(
            activeColor: navbarcolor2,
            inactiveColor: navbarcolor3,
            icon: const Icon(
              Icons.search,
              size: 25,
            ),
            title: Text(
              'Search',
              style: GoogleFonts.rubik(fontSize: 18),
            ),
          ),
          FlashyTabBarItem(
            activeColor: navbarcolor2,
            inactiveColor: navbarcolor3,
            icon: const Icon(
              Icons.settings,
              size: 25,
            ),
            title: Text(
              'Settings',
              style: GoogleFonts.rubik(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
