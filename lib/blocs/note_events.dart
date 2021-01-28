import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/model/note_model.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
  @override
  List<Object> get props => [];
}

class FetchNoteEvent extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final NoteModel note;

  const AddNoteEvent({@required this.note}):assert(note!=null);

  @override
  List<Object> get props => [note];



}
