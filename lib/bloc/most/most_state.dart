part of 'most_bloc.dart';

abstract class MostState extends Equatable {
  const MostState();
  @override
  List<Object> get props => [];
}

class MostInitial extends MostState {
  const MostInitial();
  @override
  List<Object> get props => [];
}

class DisplayMostSongs extends MostState {
  final List<Most> mostlist;
  const DisplayMostSongs({required this.mostlist});
  @override
  List<Object> get props => [mostlist];
}
