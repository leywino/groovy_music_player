import 'package:hive/hive.dart';
part 'most_played_model.g.dart';

@HiveType(typeId: 4)
class Most {
  @HiveField(0)
  String songname;
  @HiveField(1)
  String artist;
  @HiveField(2)
  int duration;
  @HiveField(3)
  String songurl;
  @HiveField(4)
  int id;
  @HiveField(5)
  int count;

  Most({
    required this.songname,
    required this.artist,
    required this.duration,
    required this.id,
    required this.songurl,
    required this.count,
  });
}

class MostBox {
  static Box<Most>? _box;
  static Box<Most> getInstance() {
    return _box ??= Hive.box('Most');
  }
}
