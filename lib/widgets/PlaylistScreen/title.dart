import 'package:firstproject/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistTitle extends StatefulWidget {
  PlaylistTitle({super.key});

  @override
  State<PlaylistTitle> createState() => _PlaylistTitleState();
}

class _PlaylistTitleState extends State<PlaylistTitle> {
  final addController = TextEditingController();
  @override
  void initState() {
    checkController();
    super.initState();
  }

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
              const Icon(
                Icons.queue_music,
                color: homeCard12,
                size: 45,
              ),
              Text(
                'Playlists',
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              addPlaylist(context);
            },
          ),
        ],
      ),
    );
  }

  addPlaylist(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: alertbg,
        title: Text(
          'Add New Playlist',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        content: TextField(
          controller: addController,
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
                    onPressed: checkController() ? null : () {},
                    child: Text(
                      'OK',
                      style: GoogleFonts.rubik(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ), 
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool checkController() {
    if (addController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Text okButton() {
    if (addController.text.isEmpty) {
      return Text(
        'OK',
        style: GoogleFonts.rubik(
          fontSize: 18,
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      return Text(
        'OK',
        style: GoogleFonts.rubik(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }
}
