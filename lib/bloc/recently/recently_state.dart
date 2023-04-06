part of 'recently_bloc.dart';

abstract class RecentlyState extends Equatable {
  const RecentlyState();
  @override
  List<Object> get props => [];
}

class RecentlyInitial extends RecentlyState {
  const RecentlyInitial();
  @override
  List<Object> get props => [];
}

class DisplayRecentlyState extends RecentlyState {
  final List<Recently> recentlylist;
  const DisplayRecentlyState({
    required this.recentlylist,
  });
  @override
  List<Object> get props => [recentlylist];
}
