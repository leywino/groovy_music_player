part of 'all_songs_bloc.dart';

abstract class AllSongsState extends Equatable {
  const AllSongsState();
  @override
  List<Object> get props => [];
}

class SongsInitial extends AllSongsState {
  const SongsInitial();
  @override
  List<Object> get props => [];
}

class DisplayAllSongs extends AllSongsState {
  final List<Songs> songlist;
  DisplayAllSongs({required this.songlist});
  @override
  List<Object> get props => [songlist];
}
