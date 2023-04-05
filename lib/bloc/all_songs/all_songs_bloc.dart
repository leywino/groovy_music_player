import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer';
part 'all_songs_event.dart';
part 'all_songs_state.dart';

@freezed
class AllSongsBloc extends Bloc<AllSongsEvent, AllSongsState> {
  AllSongsBloc() : super(SongsInitial()) {
    on<GetAllSongs>((event, emit) {
      try {
        final songbox = SongBox.getInstance();
        final songlist = songbox.values.toList();
        // print(songlist[0].songname);
        emit(DisplayAllSongs(songlist: songlist));
      } catch (e) {
        log('$e');
      }
    });
  }
}
