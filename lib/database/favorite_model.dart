import 'package:hive/hive.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class Favorite {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;

  Favorite({
    required this.songname,
    required this.artist,
    required this.duration,
    required this.id,
    required this.songurl,
  });
}

class FavoriteBox {
  static Box<Favorite>? _box;
  static Box<Favorite> getInstance() {
    return _box ??= Hive.box('Favorite');
  }
}
