import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nevis/database_model/note_db_models.dart';
import 'package:nevis/model/note_model.dart';

class MessageCardView extends StatelessWidget {
  final NoteModel note;

  MessageCardView(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70,
      ),
      padding:
          EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          noteView(),
          SizedBox(
            height: 20,
          ),
          noteDetailView()
        ],
      ),
    );
  }

  Widget noteView() {
    return InkWell(
        onLongPress: () => {},
        child: Text(
          note.context.toString(),
          style: TextStyle(fontSize: 18.0, fontFamily: 'Source Sans Pro'),
          // style: TextStyle(fontSize: 18.0, fontFamily: 'Mono'),
        ));
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
