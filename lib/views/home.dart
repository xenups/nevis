import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/blocs/edit_area/edit_blocs.dart';
import 'package:nevis/blocs/note_blocs.dart';
import 'package:nevis/repositories/note.dart';

import 'notes/edit_area.dart';
import 'notes/note_list_view.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (BuildContext context) => NoteBloc(NoteRepository())),
            BlocProvider(
                create: (BuildContext context) =>
                    EditAreaBloc(NoteRepository())),
          ],
          child: Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(60, 99, 130, 1.0),
                  Color.fromRGBO(7, 153, 146, 1.0),
                ],
              )),
              child: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [NoteListView(), EditBox()],
              )))),
    );
  }
}
