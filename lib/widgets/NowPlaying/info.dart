import 'package:flutter/material.dart';

class NPInfo extends StatelessWidget {
  const NPInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Without Me'),
              Text('Halsey'),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
