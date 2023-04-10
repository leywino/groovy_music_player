part of 'playlist_bloc.dart';

abstract class PlaylistEvent extends Equatable {
  const PlaylistEvent();

  @override
  List<Object> get props => [];
}

class GetAllPlaylist extends PlaylistEvent {
  const GetAllPlaylist();
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class DisplaySpecificPlaylist extends PlaylistEvent {
  int intindex;
  String playlistname;
  List<Songs> playlistsongs;
  DisplaySpecificPlaylist({
    required this.intindex,
    required this.playlistname,
    required this.playlistsongs,
  });
  @override
  List<Object> get props => [intindex,playlistname,playlistsongs];
}
