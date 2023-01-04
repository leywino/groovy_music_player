import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/SettingsScreen/title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsTitle(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SettingsTextButton2(
                //   settingstitle: notifications,
                //   settingsicon: Icons.notifications,
                // ),
                TextButton.icon(
                  onPressed: () {
                    Share.share("https://github.com/leywino/music_player",
                        subject: "Github Repo");
                  },
                  icon: const Icon(
                    Icons.share,
                    size: 40,
                    color: Colors.white,
                  ),
                  label: Text(
                    share,
                    style: GoogleFonts.rubik(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.lock,
                    size: 40,
                    color: Colors.white,
                  ),
                  label: Text(
                    privacy,
                    style: GoogleFonts.rubik(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.receipt,
                    size: 40,
                    color: Colors.white,
                  ),
                  label: Text(
                    terms,
                    style: GoogleFonts.rubik(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.info,
                    size: 40,
                    color: Colors.white,
                  ),
                  label: Text(
                    about,
                    style: GoogleFonts.rubik(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
