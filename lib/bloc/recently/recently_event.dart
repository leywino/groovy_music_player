part of 'recently_bloc.dart';

abstract class RecentlyEvent extends Equatable {
  const RecentlyEvent();

  @override
  List<Object> get props => [];
}

class GetAllRecently extends RecentlyEvent {
  const GetAllRecently();
  @override
  List<Object> get props => [];
}

class UpdateRecently extends RecentlyEvent {
  final Recently recsongs;
  const UpdateRecently({
    required this.recsongs,
  });
  @override
  List<Object> get props => [recsongs];
}