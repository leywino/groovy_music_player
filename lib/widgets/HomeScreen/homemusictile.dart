import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMusicTiles extends StatefulWidget {
  const HomeMusicTiles({super.key});

  @override
  State<HomeMusicTiles> createState() => _HomeMusicTilesState();
}

class _HomeMusicTilesState extends State<HomeMusicTiles> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("assets/images/tileicon.jpg"),
          ),
          title: Text(
            'Without Me',
            style: GoogleFonts.rubik(fontSize: 25, color: Colors.white),
          ),
          subtitle: Text(
            'Halsey',
            style: GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
          ),
          trailing: Wrap(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  showOptions(context);
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

showOptions(BuildContext context) {
  return AlertDialog(
    title: const Text('AlertDialog Title'),
    content: const Text('AlertDialog description'),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: const Text('OK'),
      ),
    ],
  );
}
