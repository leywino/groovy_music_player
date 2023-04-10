import 'package:firstproject/screens/home.dart';
import 'package:firstproject/screens/search.dart';
import 'package:firstproject/screens/settings.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ValueNotifier<int> navBottomBarNotifier = ValueNotifier(0);

// ignore: must_be_immutable
class NavBarBottom extends StatefulWidget {
  NavBarBottom(
      {super.key, this.songlength, required this.selectedIndex, this.allSongs});
  dynamic allSongs;
  int? songlength;
  int? selectedIndex;
  @override
  State<NavBarBottom> createState() => _NavBarBottomState();
}

class _NavBarBottomState extends State<NavBarBottom> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      const ScreenHome(),
      const ScreenSearch(),
      const ScreenSettings(),
    ];
    return Container(
      color: Colors.white.withOpacity(0),
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: navBottomBarNotifier,
          builder: (context, selectedIndex, child) {
            return Scaffold(
              // body: widget.selectedIndex != 1
              //     ? IndexedStack(
              //         index: widget.selectedIndex,
              //         children: pages,
              //       )
              //     : pages[1],
              body: pages[selectedIndex],
              bottomNavigationBar: FlashyTabBar(
                backgroundColor: navbarcolor1,
                selectedIndex: selectedIndex,
                showElevation: true,
                onItemSelected: (index) => navBottomBarNotifier.value = index,
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
          },
        ),
      ),
    );
  }
}
