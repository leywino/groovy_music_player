import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firstproject/database/playlist_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(PlaylistListInitial()) {
    on<GetAllPlaylist>((event, emit) {
      try {
        final playlistbox = PlaylistBox.getInstance();
        final playdb = playlistbox.values.toList();
        emit(DisplayPlaylistList(playdb: playdb));
      } catch (e) {
        log("$e");
      }
    });

        on<DisplaySpecificPlaylist>((event, emit) {
      try {
        final playlistbox = PlaylistBox.getInstance();
        final playdb = playlistbox.values.toList();
        emit(SpecificPlaylistShow(songdb: playdb[event.intindex].playlistsongs,index: event.intindex, playlistname: event.playlistname
        ));
      } catch (e) {
        log("$e");
      }
    });
  }
}

