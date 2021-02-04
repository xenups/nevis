import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:nevis/blocs/edit_area/edit_blocs.dart';
import 'package:nevis/blocs/edit_area/edit_events.dart';
import 'package:nevis/blocs/note_blocs.dart';
import 'package:nevis/blocs/note_events.dart';
import 'package:nevis/model/note_model.dart';
import 'package:nevis/views/focused_menu/focused_menu.dart';
import 'package:nevis/views/focused_menu/modals.dart';

class MessageCardView extends StatelessWidget {
  final NoteModel note;

  MessageCardView(this.note);

  @override
  Widget build(BuildContext context) {
    final editAreaBloc = BlocProvider.of<EditAreaBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: FocusedMenuHolder(
          child: messageCard(context),
          onPressed: () {
            print(note.context + "printed");
          },
          menuItems: <FocusedMenuItem>[
            FocusedMenuItem(
                title: Text("Share"),
                trailingIcon: Icon(Icons.share),
                onPressed: () {
                  shareText();
                }),

            FocusedMenuItem(
                title: Text("Edit"),
                trailingIcon: Icon(Icons.edit),
                onPressed: () {
                  editAreaBloc.add(ModifyEvent(note));
                }),
            FocusedMenuItem(
                title: Text("Copy"),
                trailingIcon: Icon(Icons.copy),
                onPressed: () =>
                    Clipboard.setData(new ClipboardData(text: note.context))),
            FocusedMenuItem(
                title: Text(
                  "Delete",
                  style: TextStyle(color: Colors.redAccent),
                ),
                trailingIcon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  showDialog(context);
                  // noteBloc.add(DeleteNoteEvent(note: note));
                }),

          ],
          menuWidth: MediaQuery.of(context).size.width * 0.50,
          blurSize: 2.0,
          menuItemExtent: 55,
          menuBoxDecoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          duration: Duration(milliseconds: 100),
          animateMenuItems: false,
          blurBackgroundColor: Colors.black54,
          openWithTap: false,
          menuOffset: 10.0,
          bottomOffsetHeight: 40.0),
    );
  }

  showDialog(BuildContext superContext) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: superContext,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 200,
            child: deleteDialogAlert(superContext),
            margin: EdgeInsets.only(bottom: 0, left: 0, right: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  shareText() async{
    print("share called");
    await FlutterShare.share(
        title: "copied from nevis",
        text: note.context.toString(),
    );
  }

  Widget deleteDialogAlert(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Would you like to delete this note ?",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black26,
          ),
          Expanded(
            child: FlatButton(
                onPressed: () {
                  noteBloc.add(DeleteNoteEvent(note: note));
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  "Delete",
                  style: TextStyle(fontSize: 15.0, color: Colors.red),
                )),
          ),
          Divider(
            color: Colors.black26,
          ),
          Expanded(
            child: TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                )),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget messageCard(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          color: Colors.white70,
        ),
        padding:
            EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            noteView(context),
            SizedBox(
              height: 20,
            ),
            noteDetailView()
          ],
        ));
  }

  Widget noteView(BuildContext context) {
    return Text(
      note.context.toString(),
      style: TextStyle(fontSize: 18.0, fontFamily: 'Source Sans Pro'),
    );
  }

  Widget noteDetailView() {
    var formatter = new DateFormat('yyyy-MM-dd');
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.note.daysAgo,
            style: TextStyle(fontSize: 10.0, fontFamily: 'Source Sans Pro'),
          ),
          Text(
            formatter.format(this.note.createdDate),
            style: TextStyle(fontSize: 10.0, fontFamily: 'Robo'),
          ),
        ],
      ),
    );
  }
}
