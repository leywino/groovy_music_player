part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}
class GetAllFavs extends FavoritesEvent {
  const GetAllFavs();
  @override
  List<Object> get props => [];
}

class AddToFavorite extends FavoritesEvent {
  final Favorite favlist;

  const AddToFavorite({
    required this.favlist,
  });
  @override
  List<Object> get props => [favlist];
}

class RemoveFromFavorite extends FavoritesEvent {
  final int index;

  const RemoveFromFavorite({
    required this.index,
  });
  @override
  List<Object> get props => [index];
}