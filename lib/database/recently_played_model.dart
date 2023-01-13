import 'package:hive/hive.dart';
part 'recently_played_model.g.dart';

@HiveType(typeId: 3)
class Recently {
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
  @HiveField(5)
  int? index;

  Recently({
    required this.songname,
    required this.artist,
    required this.duration,
    required this.id,
    required this.songurl,
    required this.index,
  });
}

class RecentlyBox {
  static Box<Recently>? _box;
  static Box<Recently> getInstance() {
    return _box ??= Hive.box('Recently');
  }
}
