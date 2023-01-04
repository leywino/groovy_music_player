import 'package:firstproject/widgets/SettingsScreen/switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SettingsTextButton2 extends StatelessWidget {
  SettingsTextButton2({super.key, this.settingsicon, this.settingstitle});

  String? settingstitle;
  IconData? settingsicon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: Icon(
            settingsicon,
            size: 40,
            color: Colors.white,
          ),
          label: Text(
            settingstitle!,
            style: GoogleFonts.rubik(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        const SettingsSwitch(),
      ],
    );
  }
}
