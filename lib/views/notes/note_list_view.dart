import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/blocs/note_blocs.dart';
import 'package:nevis/blocs/note_events.dart';
import 'package:nevis/blocs/note_states.dart';
import 'package:nevis/database_model/note_db_models.dart';
import 'package:nevis/model/note_model.dart';
import 'edit_area.dart';
import 'messge.dart';

class NoteListView extends StatefulWidget {
  @override
  _NoteListViewState createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  ScrollController _scrollController;
  int usersCount = 0;

  var controller = new TextEditingController();

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {}
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    noteBloc.add(FetchNoteEvent());
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteIsLoading) {
        print("too load mire");
        return Center(child: CircularProgressIndicator());
      }
      if (state is NoteIsLoaded) {
        print("note is loaded");
        return Expanded(child: notesListViewBuilder(context, state.getNotes));
      }
      if (state is NoteIsNotLoaded) {
        return Text(
          "problem happened",
          style: TextStyle(fontSize: 60),
        );
      }
      print("too akhari mire");
      return Text(
        "problem happened",
        style: TextStyle(fontSize: 60),
      );
    });
  }

  Widget home() {
    return Expanded(
        child: Container(
      child: Text("Text"),
    ));
  }

  Widget notesListViewBuilder(BuildContext context, List<NoteModel> notes) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          reverse: true,
          controller: _scrollController,
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return MessageCardView(notes[index]);
          }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  Widget blurredBackground() {
    return SizedBox(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            // Clip it cleanly.
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            ),
          ),
        ],
      ),
    );
  }
}
