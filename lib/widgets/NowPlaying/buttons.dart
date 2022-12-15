import 'package:flutter/material.dart';

class NPButtons extends StatefulWidget {
  NPButtons({super.key});

  @override
  State<NPButtons> createState() => _NPButtonsState();
}

class _NPButtonsState extends State<NPButtons> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.repeat,
            color: Colors.white,
            size: 35,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.skip_previous,
            color: Colors.white,
            size: 35,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.play_circle_fill,
            color: Colors.white,
            size: 60,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.skip_next,
            color: Colors.white,
            size: 35,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.playlist_add,
            color: Colors.white,
            size: 35,
          ),
        ),
      ],
    );
  }
}
