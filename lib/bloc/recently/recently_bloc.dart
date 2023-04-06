import 'package:bloc/bloc.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';
part 'recently_event.dart';
part 'recently_state.dart';

class RecentlyBloc extends Bloc<RecentlyEvent, RecentlyState> {
  RecentlyBloc() : super(const RecentlyInitial()) {
    on<GetAllRecently>((event, emit) {
      final recentlybox = RecentlyBox.getInstance();
      final recentlydb = recentlybox.values.toList();
      emit(DisplayRecentlyState(recentlylist: recentlydb));
    });
  }
}
