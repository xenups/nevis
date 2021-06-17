import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/blocs/edit_area/edit_blocs.dart';
import 'package:nevis/blocs/edit_area/edit_events.dart';
import 'package:nevis/blocs/edit_area/edit_states.dart';
import 'package:nevis/blocs/note_blocs.dart';
import 'package:nevis/blocs/note_events.dart';
import 'package:nevis/blocs/note_states.dart';
import 'package:nevis/model/note_model.dart';

class EditBox extends StatelessWidget {
  var focusNode = FocusNode();
  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAreaBloc, EditState>(builder: (context, state) {
      focusNode.unfocus();
      if (state is ModifyState) {
        this.controller.text = state.getNote.context;
        focusNode.requestFocus();
        return editNote(context);
      }
      focusNode.unfocus();
      return addNote(context);
    });
  }

  Widget editNote(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0.0, top: 0.0, bottom: 0.0),
      decoration: BoxDecoration(color: Color.fromRGBO(246, 246, 246, 1.0)),
      child: Row(
        children: [
          Expanded(
            child: inputNoteText(),
          ),
          editButton(context),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
    );
  }

  Widget addNote(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0.0, top: 0.0, bottom: 0.0),
      decoration: BoxDecoration(color: Color.fromRGBO(246, 246, 246, 1.0)),
      child: Row(
        children: [
          Expanded(
            child: inputNoteText(),
          ),
          addButton(context),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
    );
  }

  Widget editButton(BuildContext context) {
    // ignore: close_sinks
    final editAreaBloc = BlocProvider.of<EditAreaBloc>(context);
    // ignore: close_sinks
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    return BlocBuilder<EditAreaBloc, EditState>(builder: (context, state) {
      print("hi babe");
      return Center(
          child: new SizedBox(
              width: 40,
              height: 40,
              child: FlatButton(
                  padding: EdgeInsets.all(0),
                  highlightColor: Color.fromRGBO(13, 61, 114, 0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(35.0)),
                  child: new Icon(
                    Icons.check,
                    size: 40.0,
                    color: Color.fromRGBO(13, 61, 114, 0.9),
                  ),
                  onPressed: () {
                    if (state is ModifyState) {
                      NoteModel note = state.getNote;
                      note.context = this.controller.text;
                      note.createdDate = DateTime.now();
                      note.isSynced = true;
                      note.title = "default";
                      noteBloc.add(EditNoteEvent(note));
                      editAreaBloc.add(AddEvent());
                      noteBloc.add(FetchNoteEvent());
                      focusNode.unfocus();
                      this.controller.clear();
                    }
                  })));
    });
  }

  Widget addButton(BuildContext context) {
    // ignore: close_sinks
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    return Center(
        child: new SizedBox(
            width: 40,
            height: 40,
            child: FlatButton(
                padding: EdgeInsets.all(0),
                highlightColor: Color.fromRGBO(13, 61, 114, 0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(35.0)),
                child: new Icon(
                  Icons.add,
                  size: 40.0,
                  color: Color.fromRGBO(13, 61, 114, 0.9),
                ),
                onPressed: () {
                  NoteModel note = NoteModel();
                  note.context = this.controller.text;
                  note.title = "default";
                  note.category = 2;
                  note.createdDate = DateTime.now();
                  note.isSynced = true;
                  this.controller.clear();
                  focusNode.unfocus();
                  noteBloc.add(AddNoteEvent(note: note));
                })));
  }

  Widget inputNoteText() {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight:
              400 //put here the max height to which you need to resize the textbox
          ),
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        // data: Theme.of(context).copyWith(splashColor: Colors.black),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: TextField(
            autofocus: false,
            focusNode: focusNode,
            maxLines: null,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding:
                  const EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
              hintText: "Write a note ...",
              hintStyle: TextStyle(
                  fontSize: 20.0, color: Color.fromRGBO(142, 142, 147, 0.5)),
              focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  borderSide: new BorderSide(color: Colors.black26)),
              enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  borderSide: new BorderSide(color: Colors.black26)),
              border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  borderSide: new BorderSide(color: Colors.black26)),
            ),
            textAlign: TextAlign.left,
            controller: this.controller,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
