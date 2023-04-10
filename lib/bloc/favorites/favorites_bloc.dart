import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firstproject/database/favorite_model.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoriteInitial()) {
    on<GetAllFavs>((event, emit) {
      try {
        final favbox = FavoriteBox.getInstance();
        final favlist = favbox.values.toList();
        // print(songlist[0].songname);
        emit(DisplayAllFavs(favlist: favlist));
      } catch (e) {
        log('$e');
      }
    });

    on<AddToFavorite>((event, emit) {
      try {
        final favoritebox = FavoriteBox.getInstance();
        List<Favorite> favdb = favoritebox.values.toList();
        bool isAlreadyThere = favdb
            .where((element) => element.songname == event.favlist.songname)
            .isEmpty;
        if (isAlreadyThere == true) {
          favoritebox.add(event.favlist);
          // ScaffoldMessenger.of(snackbarKey.currentContext!)
          //     .showSnackBar(const SnackBar(
          //   duration: Duration(seconds: 1),
          //   behavior: SnackBarBehavior.floating,
          //   content: Text("Added to favorites"),
          // ));
        } else {
          int sindex = favdb.indexWhere(
              (element) => element.songname == event.favlist.songname);
          favoritebox.deleteAt(sindex);

          // ScaffoldMessenger.of(snackbarKey.currentContext!)
          //     .showSnackBar(const SnackBar(
          //   duration: Duration(seconds: 1),
          //   behavior: SnackBarBehavior.floating,
          //   content: Text("Removed from favorites"),
          // ));
        }
        add(const GetAllFavs());
      } catch (e) {
        log("$e");
      }
    });

    on<RemoveFromFavorite>((event, emit) async {
      try {
        final favoritebox = FavoriteBox.getInstance();
        await favoritebox.deleteAt(event.index);
        // print(songlist[0].songname);
        add(const GetAllFavs());
      } catch (e) {
        log('$e');
      }
    });
  }
}
