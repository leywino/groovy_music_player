part of 'all_songs_bloc.dart';


abstract class AllSongsEvent extends Equatable {
  const AllSongsEvent();

  @override
  List<Object> get props => [];
}
class GetAllSongs extends AllSongsEvent {
  const GetAllSongs();

  @override
  List<Object> get props => [];
}