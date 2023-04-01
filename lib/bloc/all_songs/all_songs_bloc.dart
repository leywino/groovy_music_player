import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_songs_event.dart';
part 'all_songs_state.dart';

class AllSongsBloc extends Bloc<AllSongsEvent, AllSongsState> {
  AllSongsBloc() : super(AllSongsInitial()) {
    on<AllSongsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
