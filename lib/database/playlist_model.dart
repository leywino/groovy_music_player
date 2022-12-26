import 'package:firstproject/database/song_model.dart';
import 'package:hive/hive.dart';
part 'playlist_model.g.dart';


@HiveType(typeId: 2)
class Playlist {
  @HiveField(0)
  String? playlistname;
  @HiveField(1)
  List<Songs>? playlistsongs;

  Playlist({
    required this.playlistname,
    required this.playlistsongs,
  });
}

class PlaylistBox {
  static Box<Playlist>? _box;
  static Box<Playlist> getInstance() {
    return _box ??= Hive.box('Playlist');
  }
}
