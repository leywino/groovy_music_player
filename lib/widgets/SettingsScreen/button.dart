import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTextButton extends StatelessWidget {
  SettingsTextButton({super.key, this.settingsicon, this.settingstitle});

  String? settingstitle;
  IconData? settingsicon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          
        },
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
        ));
  }
}
