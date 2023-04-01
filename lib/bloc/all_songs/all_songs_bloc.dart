import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_songs_event.dart';
part 'all_songs_state.dart';
part 'all_songs_bloc.freezed.dart';

class AllSongsBloc extends Bloc<AllSongsEvent, AllSongsState> {
  AllSongsBloc() : super(_Initial()) {
    on<AllSongsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
