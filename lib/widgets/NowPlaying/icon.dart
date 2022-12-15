import 'package:flutter/material.dart';

class NPIcon extends StatelessWidget {
  NPIcon({super.key, this.intindex});
  final intindex;

  final images = [
    'assets/images/withoutme.jpg',
    'assets/images/jocelyn.jpg',
    'assets/images/history.jpg',
    'assets/images/happier.jpg',
    'assets/images/everything.jpg',
    'assets/images/older.jpg',
    'assets/images/imgood.jpg',
    'assets/images/attention.jpg',
  ];

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
            child: Image.asset(images[intindex])),
      ),
    );
  }
}
