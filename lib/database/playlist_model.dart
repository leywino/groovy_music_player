import 'package:firstproject/database/song_model.dart';
import 'package:hive/hive.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class Playlists {
  @HiveField(0)
  String playlistname;
  @HiveField(1)
  List<Songs> playlistsongs;

  Playlists({
    required this.playlistname,
    required this.playlistsongs,
  });
}

class PlaylistBox {
  static Box<Playlists>? _box;
  static Box<Playlists> getInstance() {
    return _box ??= Hive.box('Playlist');
  }
}
