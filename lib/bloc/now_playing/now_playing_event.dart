part of 'now_playing_bloc.dart';

@freezed
class NowPlayingEvent with _$NowPlayingEvent {
  const factory NowPlayingEvent.started() = _Started;
}