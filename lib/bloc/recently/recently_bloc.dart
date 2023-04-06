import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';
part 'recently_event.dart';
part 'recently_state.dart';

class RecentlyBloc extends Bloc<RecentlyEvent, RecentlyState> {
  RecentlyBloc() : super(const RecentlyInitial()) {
    on<GetAllRecently>((event, emit) {
      try {
        final recentlybox = RecentlyBox.getInstance();
        final recentlydb = recentlybox.values.toList();
        emit(DisplayRecentlyState(recentlylist: recentlydb));
      } catch (e) {
        log("$e");
      }
    });

    on<UpdateRecently>((event, emit) {
      try {
        final recentlybox = RecentlyBox.getInstance();
        final list = recentlybox.values.toList();
        bool isAlreadyAdded = list
            .where((element) => element.songname == event.recsongs.songname)
            .isEmpty;
        if (isAlreadyAdded == true) {
          recentlybox.add(event.recsongs);
        } else {
          int intindex = list.indexWhere(
              (element) => element.songname == event.recsongs.songname);
          recentlybox.deleteAt(intindex);
          recentlybox.add(event.recsongs);
        }
        add(const GetAllRecently());
      } catch (e) {
        log("$e");
      }
    });
  }
}
