import 'package:firstproject/bloc/all_songs/all_songs_bloc.dart';
import 'package:firstproject/bloc/favorites/favorites_bloc.dart';
import 'package:firstproject/bloc/most_played/most_played_bloc.dart';
import 'package:firstproject/bloc/now_playing/now_playing_bloc.dart';
import 'package:firstproject/bloc/playlist/playlist_bloc.dart';
import 'package:firstproject/bloc/recently_played/recently_played_bloc.dart';
import 'package:firstproject/database/favorite_model.dart';
import 'package:firstproject/database/most_played_model.dart';
import 'package:firstproject/database/playlist_model.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:firstproject/database/song_model.dart';
import 'package:firstproject/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>('Songs');
  Hive.registerAdapter(FavoriteAdapter());
  await Hive.openBox<Favorite>('Favorite');
  Hive.registerAdapter(PlaylistsAdapter());
  await Hive.openBox<Playlists>('Playlist');
  Hive.registerAdapter(RecentlyAdapter());
  await Hive.openBox<Recently>('Recently');
  Hive.registerAdapter(MostAdapter());
  await Hive.openBox<Most>('Most');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllSongsBloc(),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(),
        ),
          BlocProvider(
          create: (context) => MostPlayedBloc(),
        ),
        BlocProvider(
          create: (context) => NowPlayingBloc(),
        ),
          BlocProvider(
          create: (context) => PlaylistBloc(),
        ),
        BlocProvider(
          create: (context) => RecentlyPlayedBloc(),
        ),
      ],
      child:MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.black.withOpacity(0),
          ),
          textTheme: GoogleFonts.kanitTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const ScreenSplash(),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
