import 'package:firstproject/bloc/playlist/playlist_bloc.dart';
import 'package:firstproject/database/playlist_model.dart';
import 'package:firstproject/utilities/colors.dart';
import 'package:firstproject/widgets/add_to_playlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistTitle extends StatelessWidget {
  static ValueNotifier<bool> editPlaylistOrNot = ValueNotifier(false);
  PlaylistTitle({super.key});

  final addController = TextEditingController();

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
          const Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
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
                  editPlaylistOrNot.value = !editPlaylistOrNot.value;
                },
                child: ValueListenableBuilder(
                  valueListenable: editPlaylistOrNot,
                  builder: (context, editPlaylistbool, child) => Center(
                    child: !editPlaylistbool
                        ? Container(
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.edit,
                                color: mainBgColor,
                                size: 22,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.check_circle_rounded,
                            size: 36,
                            color: Colors.green,
                          ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
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
                        return BlocBuilder<PlaylistBloc, PlaylistState>(
                          builder: (ctx, state) {
                            return TextButton(
                              onPressed: addController.text.isEmpty
                                  ? null
                                  : !checkIfAlreadyExists(addController.text)
                                      ? () async {
                                          ctx
                                              .read<PlaylistBloc>()
                                              .add(const GetAllPlaylist());
                                          playlistbox.add(Playlists(
                                              playlistname: addController.text,
                                              playlistsongs: []));
                                          Navigator.pop(context);
                                          addController.clear();
                                        }
                                      : () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
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
                          },
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
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
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
