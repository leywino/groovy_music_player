import 'package:firstproject/database/playlist_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/FavoriteScreen/list.dart';
import 'package:firstproject/widgets/PlaylistScreen/playlists.dart';
import 'package:firstproject/widgets/RecentlyPlayed/list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistList extends StatefulWidget {
  PlaylistList({super.key});

  @override
  State<PlaylistList> createState() => _PlaylistListState();
}

class _PlaylistListState extends State<PlaylistList> {
  final playlistbox = PlaylistBox.getInstance();
  final songbox = SongBox.getInstance();

  late List<Songs> songsdb = songbox.values.toList();

  @override
  Widget build(BuildContext context) {
    final editController = TextEditingController();
    double vww = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
        valueListenable: playlistbox.listenable(),
        builder: (context, playdbbox, child) {
          List<Playlists> playdbs = playdbbox.values.toList();
          return playdbs.isEmpty
              ? Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: vww * 0.05),
                      child: Text(
                        'You have no playlists!',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ],
                )
              : ValueListenableBuilder<Box<Playlists>>(
                  valueListenable: playlistbox.listenable(),
                  builder: (context, playlistbox, child) {
                    List<Playlists> playdb = playlistbox.values.toList();
                    return ListView.builder(
                        itemCount: playdb.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (ctx) {
                                  return PlaylistSongList(intindex: index);
                                },
                              ));
                            },
                            leading: playdb[index].playlistsongs.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: QueryArtworkWidget(
                                      artworkBorder: BorderRadius.circular(8),
                                      keepOldArtwork: true,
                                      id: playdb[index].playlistsongs[0].id!,
                                      type: ArtworkType.AUDIO,
                                    ),
                                  )
                                : Image.asset('assets/images/music.jpg'),
                            title: Text(
                              playdb[index].playlistname,
                              style: GoogleFonts.rubik(
                                  fontSize: 20, color: Colors.white),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(bottom: vww * 0.035),
                              child: Text(
                                "${playdb[index].playlistsongs.length} songs",
                                style: GoogleFonts.rubik(
                                    color: Colors.grey, fontSize: 18),
                              ),
                            ),
                            trailing: Wrap(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: vww * 0.035),
                                  child: IconButton(
                                    onPressed: () {
                                      editPlaylist(context, editController,
                                          index, playlistbox);
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
                                    setState(() {
                                      deletePlaylist(
                                          context, index, playlistbox);
                                    });
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
                  });
        });
  }
}

deletePlaylist(BuildContext context, int index, Box<Playlists> playlistbox) {
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
                  onPressed: () {
                    playlistbox.deleteAt(index);
                    Navigator.pop(context);
                  },
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

editPlaylist(BuildContext context, TextEditingController editController,
    int index, Box<Playlists> playlistbox) {
  final playdb = playlistbox.values.toList();
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: alertbg,
      title: Text(
        'Rename',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      content: TextField(
        controller: editController,
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
                ValueListenableBuilder(
                    valueListenable: editController,
                    builder: (context, controller, child) {
                      return TextButton(
                        onPressed: controller.text.isEmpty
                            ? null
                            : () {
                                playlistbox.putAt(
                                    index,
                                    Playlists(
                                        playlistname: editController.text,
                                        playlistsongs:
                                            playdb[index].playlistsongs));
                                Navigator.pop(context);
                              },
                        child: Text(
                          'OK',
                          style: GoogleFonts.rubik(
                            fontSize: 18,
                            color: controller.text.isEmpty
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
