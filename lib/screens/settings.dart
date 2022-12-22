import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/SettingsScreen/button.dart';
import 'package:firstproject/widgets/SettingsScreen/button2.dart';
import 'package:firstproject/widgets/SettingsScreen/title.dart';
import 'package:flutter/material.dart';

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
            SettingsTitle(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsTextButton2(
                  settingstitle: notifications,
                  settingsicon: Icons.notifications,
                ),
                SettingsTextButton(
                  settingstitle: share,
                  settingsicon: Icons.share,
                ),
                SettingsTextButton(
                  settingstitle: privacy,
                  settingsicon: Icons.lock,
                ),
                SettingsTextButton(
                  settingstitle: terms,
                  settingsicon: Icons.receipt,
                ),
                SettingsTextButton(
                  settingstitle: about,
                  settingsicon: Icons.info,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
