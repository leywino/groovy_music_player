import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recently_played_event.dart';
part 'recently_played_state.dart';
part 'recently_played_bloc.freezed.dart';

class RecentlyPlayedBloc extends Bloc<RecentlyPlayedEvent, RecentlyPlayedState> {
  RecentlyPlayedBloc() : super(_Initial()) {
    on<RecentlyPlayedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
