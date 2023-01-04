import 'package:firstproject/screens/playlists.dart';
import 'package:firstproject/widgets/navbar.dart';
import 'package:flutter/material.dart';

class NPNav extends StatelessWidget {
  const NPNav({super.key});

  @override
  Widget build(BuildContext context) {
    double vwh = MediaQuery.of(context).size.height;
    double vww = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: vwh * 0.08),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: EdgeInsets.only(
            left: vww * 0.03,
            right: vww * 0.03,
          ),
          child: Wrap(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => NavBarBottom(selectedIndex: 0),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const ScreenPlaylists(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => NavBarBottom(selectedIndex: 1),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
