import 'package:firstproject/utilities/colors.dart';
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
                  settingstitle: 'Notifications',
                  settingsicon: Icons.notifications,
                ),
                SettingsTextButton(
                  settingstitle: 'Share',
                  settingsicon: Icons.share,
                ),
                SettingsTextButton(
                  settingstitle: 'Privacy Policies',
                  settingsicon: Icons.lock,
                ),
                SettingsTextButton(
                  settingstitle: 'Terms & Conditions',
                  settingsicon: Icons.receipt,
                ),
                SettingsTextButton(
                  settingstitle: 'About',
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
