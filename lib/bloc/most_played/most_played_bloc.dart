import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'most_played_event.dart';
part 'most_played_state.dart';
part 'most_played_bloc.freezed.dart';

class MostPlayedBloc extends Bloc<MostPlayedEvent, MostPlayedState> {
  MostPlayedBloc() : super(_Initial()) {
    on<MostPlayedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
