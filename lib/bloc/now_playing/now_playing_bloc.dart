import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';
part 'now_playing_bloc.freezed.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  NowPlayingBloc() : super(_Initial()) {
    on<NowPlayingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
