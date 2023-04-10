import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firstproject/database/most_played_model.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
part 'most_event.dart';
part 'most_state.dart';

class MostBloc extends Bloc<MostEvent, MostState> {
  MostBloc() : super(const MostInitial()) {
    on<GetMostSongs>((event, emit) {
        try {
        final mostbox = MostBox.getInstance();
        final mostlist = mostbox.values.toList();
        // print(mostlist[0].mostname);
        emit(DisplayMostSongs(mostlist: mostlist));
      } catch (e) {
        log('$e');
      }
    });
  }
}
