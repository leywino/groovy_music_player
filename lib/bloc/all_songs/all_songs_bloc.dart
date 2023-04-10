import 'package:bloc/bloc.dart';
import 'package:firstproject/database/song_model.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'dart:developer';
part 'all_songs_event.dart';
part 'all_songs_state.dart';


class AllSongsBloc extends Bloc<AllSongsEvent, AllSongsState> {
  AllSongsBloc() : super(const SongsInitial()) {
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
