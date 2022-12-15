import 'package:firstproject/utilities/colors.dart';
import 'package:flutter/material.dart';

class AllbumTitle extends StatelessWidget {
  AllbumTitle({super.key});
  final addController = TextEditingController();
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
            children: [
              SizedBox(
                  height: 45,
                  child: Image.asset("assets/images/albumicon.png")),
              Text(
                'Albums',
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ],
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.add_circle,
          //     color: Colors.white,
          //     size: 35,
          //   ),
          //   onPressed: () {
          //     addPlaylist(context);
          //   },
          // ),
        ],
      ),
    );
  }
}
