part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object> get props => [];
}
class FavoriteInitial extends FavoritesState {
  const FavoriteInitial();
  @override
  List<Object> get props => [];
}

class DisplayAllFavs extends FavoritesState {
  final List<Favorite> favlist;
  const DisplayAllFavs({required this.favlist});
  @override
  List<Object> get props => [favlist];
}