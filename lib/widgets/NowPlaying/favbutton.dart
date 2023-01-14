// // ignore_for_file: camel_case_types

// import 'package:firstproject/database/favorite_model.dart';
// import 'package:firstproject/database/song_model.dart';
// import 'package:firstproject/widgets/FavoriteScreen/list.dart';
// import 'package:flutter/material.dart';

// class NPFavButton extends StatefulWidget {
//   int index;
//   NPFavButton({super.key, required this.index});

//   @override
//   State<NPFavButton> createState() => _NPFavButtonState();
// }

// class _NPFavButtonState extends State<NPFavButton> {
//   List<Favorite> fav = [];
//   bool favourited = false;
//   final box = SongBox.getInstance();
//   late List<Songs> dbsongs = box.values.toList();

//   @override
//   void initState() {
//     dbsongs = box.values.toList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     fav = favoritebox.values.toList();
//     return fav
//             .where(
//                 (element) => element.songname == dbsongs[widget.index].songname)
//             .isEmpty
//         ? IconButton(
//             onPressed: () {
//               setState(() {
//                 favoritebox.add(Favorite(
//                     songname: dbsongs[widget.index].songname,
//                     artist: dbsongs[widget.index].artist,
//                     duration: dbsongs[widget.index].duration,
//                     songurl: dbsongs[widget.index].songurl,
//                     id: dbsongs[widget.index].id,
//                     index: widget.index));
//               });
//               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                 duration: Duration(seconds: 1),
//                 behavior: SnackBarBehavior.floating,
//                 content: Text("Added to favourites"),
//               ));
//             },
//             icon: const Icon(
//               Icons.favorite_border,
//               color: Colors.white,
//             ))
//         : IconButton(
//             onPressed: () async {
//               if (favoritebox.length < 1) {
//                 favoritebox.clear();
//                 setState(() {});
//               } else {
//                 int currentindex = fav.indexWhere((element) =>
//                     element.id == dbsongs[fav[widget.index].index!].id);
//                 await favoritebox.deleteAt(currentindex);
//                 setState(() {});
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     behavior: SnackBarBehavior.floating,
//                     duration: Duration(seconds: 1),
//                     content: Text("Removed from favourites")));
//               }
//             },
//             icon: const Icon(
//               Icons.favorite,
//               color: Colors.pink,
//             ));
//   }
// }
