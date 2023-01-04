import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:flutter/material.dart';

class RecentlyTitle extends StatelessWidget {
  const RecentlyTitle({super.key});
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
            children: const [
              Icon(
                Icons.history,
                color: homeCard42,
                size: 45,
              ),
              Text(
                recently,
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
