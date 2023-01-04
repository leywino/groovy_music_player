import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:flutter/material.dart';

class MostTitle extends StatelessWidget {
  const MostTitle({super.key});
  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    double vwh = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: vww * 0.05, vertical: vwh * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Icon(
                Icons.repeat,
                color: homeCard32,
                size: 45,
              ),
              const Text(
                most,
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
