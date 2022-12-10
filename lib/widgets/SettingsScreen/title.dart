import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(vww * 0.05, vww * 0.05, 0, vww * 0.05),
      child: Text(
        'Settings',
        style: GoogleFonts.rubik(
            color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }
}
