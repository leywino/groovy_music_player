import 'package:firstproject/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard1 extends StatelessWidget {
  const HomeCard1(
      {super.key,
      this.cardcolor,
      this.iconcolor,
      this.cardicon,
      this.cardtitle});
  final Color? cardcolor;
  final Color? iconcolor;
  final IconData? cardicon;
  final String? cardtitle;

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;
    return InkWell(
      child: SizedBox(
        width: vww * 0.3,
        height: vwh * 0.17,
        child: Card(
          color: cardcolor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                cardicon,
                size: 60,
                color: iconcolor,
              ),
              Text(
                cardtitle!,
                style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        print("Click event on Container");
      },
    );
  }
}
