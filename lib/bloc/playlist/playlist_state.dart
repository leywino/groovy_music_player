part of 'playlist_bloc.dart';

abstract class PlaylistState extends Equatable {
  const PlaylistState();
  @override
  List<Object> get props => [];
}

class PlaylistListInitial extends PlaylistState {
  const PlaylistListInitial();
  @override
  List<Object> get props => [];
}

class DisplayPlaylistList extends PlaylistState {
  final List<Playlists> playdb;
  DisplayPlaylistList({required this.playdb});
  @override
  List<Object> get props => [playdb];
}

class SpecificPlaylistIntitial extends PlaylistState {
  final List<Playlists> playdb;
  SpecificPlaylistIntitial({required this.playdb});
  @override
  List<Object> get props => [playdb];
}

class SpecificPlaylistShow extends PlaylistState {
  final List<Songs> songdb;
  final int index;
  final String playlistname;
  const SpecificPlaylistShow({required this.songdb, required this.index, required this.playlistname});
  @override
  List<Object> get props => [songdb,index,playlistname];
}
