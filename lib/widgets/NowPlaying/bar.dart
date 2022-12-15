import 'package:flutter/material.dart';

class NPBar extends StatelessWidget {
  const NPBar({super.key});

  @override
  Widget build(BuildContext context) {
    double vwh = MediaQuery.of(context).size.height;
    double vww = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Slider(
          onChanged: (value) {},
          value: 0.33,
        ),
        Padding(
          padding: EdgeInsets.only(left: vww * 0.05, right: vww * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0:53',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                '3:49',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        )
      ],
    );
  }
}
