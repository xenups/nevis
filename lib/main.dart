import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/repositories/note.dart';
import 'package:nevis/views/home.dart';
import 'package:nevis/views/intro_screen.dart';
import 'package:nevis/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/edit_area/edit_blocs.dart';
import 'blocs/note_blocs.dart';
import 'database_model/util.dart';

Future<void> main() async {
  await setupLocator();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => NoteBloc(NoteRepository())),
          BlocProvider(
              create: (BuildContext context) => EditAreaBloc(NoteRepository())),
        ],
        child: MaterialApp(
          initialRoute: SplashScreenView.id,
          routes: {
            IntroScreen.id: (context) => IntroScreen(),
            Home.id: (context) => Home(),
            SplashScreenView.id: (context) => SplashScreenView(),
          },
        ));
  }
}
