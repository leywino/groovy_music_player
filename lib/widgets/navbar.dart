import 'package:firstproject/screens/home.dart';
import 'package:firstproject/screens/search.dart';
import 'package:firstproject/screens/settings.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBarBottom extends StatefulWidget {
  const NavBarBottom({super.key});

  @override
  State<NavBarBottom> createState() => _NavBarBottomState();
}

class _NavBarBottomState extends State<NavBarBottom> {
  int _selectedIndex = 0;
  final _pages = [
    const ScreenHome(),
    ScreenSearch(),
    const ScreenSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: navbarcolor1,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            activeColor: navbarcolor2,
            inactiveColor: navbarcolor3,
            icon: Icon(
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
            icon: Icon(
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
            icon: Icon(
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
