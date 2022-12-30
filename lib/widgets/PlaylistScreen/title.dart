import 'package:firstproject/database/playlist_model.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/add_to_playlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistTitle extends StatefulWidget {
  static ValueNotifier<bool> editPlaylistOrNot =
      ValueNotifier(editPlaylistBool);
  static bool editPlaylistBool = false;
  PlaylistTitle({super.key});

  @override
  State<PlaylistTitle> createState() => _PlaylistTitleState();
}

class _PlaylistTitleState extends State<PlaylistTitle> {
  final addController = TextEditingController();
  @override
  void initState() {
    PlaylistTitle.editPlaylistOrNot.value = false;
    super.initState();
  }

  @override
  void dispose() {
    addController.dispose();
    super.dispose();
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
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    PlaylistTitle.editPlaylistOrNot.value =
                        !PlaylistTitle.editPlaylistOrNot.value;
                  });
                },
                child: Center(
                  child: !PlaylistTitle.editPlaylistOrNot.value
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              Icons.edit,
                              color: mainBgColor,
                              size: 22,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.check_circle_rounded,
                          size: 36,
                          color: Colors.green,
                        ),
                ),
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
          )
        ],
      ),
    );
  }

  addPlaylist(BuildContext context) {
    showDialog(
      barrierDismissible: false,
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
                      addController.clear();
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
                  ValueListenableBuilder<TextEditingValue>(
                      valueListenable: addController,
                      builder: (context, controller, child) {
                        return TextButton(
                          onPressed: addController.text.isEmpty
                              ? null
                              : !checkIfAlreadyExists(addController.text)
                                  ? () async {
                                      playlistbox.add(Playlists(
                                          playlistname: addController.text,
                                          playlistsongs: []));
                                      Navigator.pop(context);
                                      addController.clear();
                                    }
                                  : () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.black,
                                              content: Text(
                                                  'Playlist already exists')));
                                    },
                          child: Text(
                            'OK',
                            style: GoogleFonts.rubik(
                              fontSize: 18,
                              color: addController.text.isEmpty
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
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
