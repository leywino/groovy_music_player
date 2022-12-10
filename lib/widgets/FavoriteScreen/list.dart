import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteLists extends StatefulWidget {
  const FavoriteLists({super.key});

  @override
  State<FavoriteLists> createState() => _FavoriteListsState();
}

class _FavoriteListsState extends State<FavoriteLists> {
  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("assets/images/tileicon.jpg"),
          ),
          title: Text(
            'Without Me',
            style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(bottom: vww * 0.035),
            child: Text(
              'Halsey',
              style: GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.only(bottom: vww * 0.035),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        );
      },
    );
  }
}
