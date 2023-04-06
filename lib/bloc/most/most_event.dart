part of 'most_bloc.dart';

abstract class MostEvent extends Equatable {
  const MostEvent();

  @override
  List<Object> get props => [];
}

class GetMostSongs extends MostEvent {
  const GetMostSongs();

  @override
  List<Object> get props => [];
}