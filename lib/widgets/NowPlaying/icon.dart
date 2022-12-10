import 'package:flutter/material.dart';

class NPIcon extends StatelessWidget {
  const NPIcon({super.key});

  @override
  Widget build(BuildContext context) {
    double vwh = MediaQuery.of(context).size.height;
    double vww = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(vww * 0.05),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
          ),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset("assets/images/tileicon.jpg")),
      ),
    );
  }
}
