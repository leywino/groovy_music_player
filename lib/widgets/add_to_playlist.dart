import 'package:firstproject/database/playlist_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'package:hive_flutter/hive_flutter.dart';

final formGlobalKey = GlobalKey<FormState>();
final songbox = SongBox.getInstance();
final playlistbox = PlaylistBox.getInstance();
List<Playlists> playdb = playlistbox.values.toList();
final addController = TextEditingController();

addPlaylist(BuildContext context, int songindex) {
  playlistbox.isEmpty
      ? showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: alertbg,
            title: const Text(
              'Add New Playlist',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            content: TextField(
              controller: addController,
              style: GoogleFonts.rubik(color: Colors.white),
              decoration: const InputDecoration(
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
                          builder: (context, addController, child) {
                            return TextButton(
                              onPressed: (addController.text.isEmpty ||
                                      checkIfAlreadyExists(addController.text))
                                  ? null
                                  : () async {
                                      await playlistbox.add(Playlists(
                                          playlistname: addController.text,
                                          playlistsongs: []));
                                      // ignore: use_build_context_synchronously
                                      showPlaylistList(context, songindex);
                                    },
                              child: Text(
                                'OK',
                                style: GoogleFonts.rubik(
                                  fontSize: 18,
                                  color: (addController.text.isEmpty ||
                                          checkIfAlreadyExists(
                                              addController.text))
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
        )
      : showPlaylistList(context, songindex);
}

bool checkIfAlreadyExists(String value) {
  List<Playlists> list = playlistbox.values.toList();
  bool isAlreadyAdded =
      list.where((element) => element.playlistname == value.trim()).isNotEmpty;
  return isAlreadyAdded;
}

createNewPlaylist(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: alertbg,
          title: const Text(
            'Add New Playlist',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          content: TextField(
            controller: addController,
            style: GoogleFonts.rubik(color: Colors.white),
            decoration: const InputDecoration(
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
                            onPressed: (addController.text.isEmpty ||
                                    checkIfAlreadyExists(addController.text))
                                ? null
                                : () async {
                                    await playlistbox.add(Playlists(
                                        playlistname: addController.text,
                                        playlistsongs: []));
                                    addController.clear();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  },
                            child: Text(
                              'OK',
                              style: GoogleFonts.rubik(
                                fontSize: 18,
                                color: (addController.text.isEmpty ||
                                        checkIfAlreadyExists(
                                            addController.text))
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
        );
      },
    ),
  );
}

showPlaylistList(BuildContext context, int songindex) {
  double vww = MediaQuery.of(context).size.width;
  double vwh = MediaQuery.of(context).size.height;
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: mainBgColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Playlists',
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                onPressed: () {
                  createNewPlaylist(context);
                },
              ),
            ],
          ),
          content: Container(
            color: mainBgColor,
            height: vwh * 0.3,
            width: 0.3 * vww,
            child: ValueListenableBuilder<Box<Playlists>>(
                valueListenable: playlistbox.listenable(),
                builder: (context, playdbbox, child) {
                  List<Playlists> playdb = playdbbox.values.toList();
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: playdb.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            List<Songs> playsongdb =
                                playdb[index].playlistsongs;
                            List<Songs> songdb = songbox.values.toList();
                            bool isAlreadyAdded = playsongdb.any((element) =>
                                element.id == songdb[songindex].id);

                            if (!isAlreadyAdded) {
                              playsongdb.add(Songs(
                                songname: songdb[songindex].songname,
                                artist: songdb[songindex].artist,
                                duration: songdb[songindex].duration,
                                songurl: songdb[songindex].songurl,
                                id: songdb[songindex].id,
                              ));

                              playlistbox.putAt(
                                  index,
                                  Playlists(
                                      playlistname: playdb[index].playlistname,
                                      playlistsongs: playsongdb));

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Text(
                                      '${songdb[songindex].songname}Added to ${playdb[index].playlistname}')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Text(
                                      '${songdb[songindex].songname} is already added')));
                            }
                            Navigator.pop(context);
                          },
                          title: Text(
                            playdb[index].playlistname,
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        );
                      });
                }),
          )));
}
