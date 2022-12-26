import 'package:firstproject/database/playlist_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final formGlobalKey = GlobalKey<FormState>();
final box = PlaylistBox.getInstance();
final _textEditingController = TextEditingController();
Future<dynamic> playlistBottomSheet(BuildContext context, int songindex) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
          builder: (context, setState) => Container(
                height: 200,
                color: const Color.fromARGB(255, 0, 0, 0),
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, Box<Playlist> playlistbox, _) {
                    List<Playlist> playlist = playlistbox.values.toList();

                    if (playlistbox.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    "Create a playlist.",
                                    style: TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 35,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) =>
                                          bottomSheet(context),
                                    );
                                  },
                                  child: const Text("Create Playlist"))
                            ],
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Your Playlists.",
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: playlist.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        playlist[index].playlistname.toString(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      onTap: () {
                                        Playlist? plsongs =
                                            playlistbox.getAt(index);
                                        List<Songs>? plnewsongs =
                                            plsongs!.playlistsongs;
                                        Box<Songs> box = Hive.box('Songs');
                                        List<Songs> dbAllsongs =
                                            box.values.toList();
                                        bool isAlreadyAdded = plnewsongs!.any(
                                            (element) =>
                                                element.id ==
                                                dbAllsongs[songindex].id);

                                        if (!isAlreadyAdded) {
                                          plnewsongs.add(Songs(
                                            songname:
                                                dbAllsongs[songindex].songname,
                                            artist:
                                                dbAllsongs[songindex].artist,
                                            duration:
                                                dbAllsongs[songindex].duration,
                                            songurl:
                                                dbAllsongs[songindex].songurl,
                                            id: dbAllsongs[songindex].id,
                                          ));

                                          playlistbox.putAt(
                                              index,
                                              Playlist(
                                                  playlistname: playlist[index]
                                                      .playlistname,
                                                  playlistsongs: plnewsongs));

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: Text(
                                                      '${dbAllsongs[songindex].songname}Added to ${playlist[index].playlistname}')));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: Text(
                                                      '${dbAllsongs[songindex].songname} is already added')));
                                        }
                                        Navigator.pop(context);
                                      },
                                    );
                                  }))
                        ],
                      ),
                    );
                  },
                ),
              ));
    },
  );
}

Widget bottomSheet(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Container(
      height: 250,
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [playlistform(context)],
      ),
    ),
  );
}

Padding playlistform(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: InkWell(
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                "C",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey),
              ),
              Text(
                "reate playlist.",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formGlobalKey,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.black,
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.5)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.5)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.5)),
                hintText: "Enter a name",
                hintStyle: TextStyle(color: Color.fromARGB(255, 137, 137, 137)),
              ),
              controller: _textEditingController,
              cursorHeight: 25,
              validator: (value) {
                List<Playlist> values = box.values.toList();

                bool isAlreadyAdded = values
                    .where((element) => element.playlistname == value!.trim())
                    .isNotEmpty;

                if (value!.trim() == '') {
                  return 'Name required';
                }
                if (value.trim().length > 15) {
                  return 'Enter Characters below 15 ';
                }

                if (isAlreadyAdded) {
                  return 'Name Already Exists';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          formButtons(context)
        ],
      ),
    ),
  );
}

Row formButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel")),
      ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          onPressed: () {
            final isValid = formGlobalKey.currentState!.validate();
            if (isValid) {
              box.add(Playlist(
                  playlistname: _textEditingController.text,
                  playlistsongs: []));
              Navigator.pop(context);
            }
          },
          child: const Text("Create"))
    ],
  );
}
