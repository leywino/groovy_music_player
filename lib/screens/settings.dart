import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/SettingsScreen/settings_pop.dart';
import 'package:firstproject/widgets/SettingsScreen/title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0),
      child: SafeArea(
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
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return SettingsMenuPop(mdFileName: 'privacy.md');
                          });
                    },
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
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return SettingsMenuPop(mdFileName: 'terms.md');
                          });
                    },
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
                    onPressed: () {
                      showAboutDialog(
                          context: context,
                          applicationName: "Groovy",
                          applicationIcon: Image.asset(
                            "assets/images/logo.png",
                            height: 64,
                            width: 64,
                          ),
                          applicationVersion: "1.0",
                          children: [
                            const Text(
                                "Groovy is a simple local music player which allows use to hear music from internal storage and also do functions like add to favorites, create playlists, recently played, mostly played etc."),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("App developed by Muhammad Arshad")
                          ]);
                    },
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
      ),
    );
  }
}
