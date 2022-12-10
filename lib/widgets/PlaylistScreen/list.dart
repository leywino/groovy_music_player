import 'package:firstproject/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistList extends StatelessWidget {
  const PlaylistList({super.key});

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
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
            trailing: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: vww * 0.035),
                  child: IconButton(
                    onPressed: () {
                      editPlaylist(context);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    deletePlaylist(context);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

deletePlaylist(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: alertbg,
      title: Text(
        'Are you sure you want to delete the playlist?',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Confirm',
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

editPlaylist(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: alertbg,
      title: Text(
        'Rename',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      content: TextField(
        style: GoogleFonts.rubik(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'OK',
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
