import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/model/category_model.dart';
import 'package:nevis/model/note_model.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class FetchNoteEvent extends NoteEvent {
  final CategoryModel category;

  const FetchNoteEvent({@required this.category});

  @override
  List<Object> get props => [category];
}

class ChangeCategoryEvent extends NoteEvent {
  final CategoryModel category;

  ChangeCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class FetchCategoryEvent extends NoteEvent {
  final CategoryModel category;

  FetchCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class AddNoteEvent extends NoteEvent {
  final NoteModel note;

  const AddNoteEvent({@required this.note}) : assert(note != null);

  @override
  List<Object> get props => [note];
}

class DeleteNoteEvent extends NoteEvent {
  final NoteModel note;

  const DeleteNoteEvent({@required this.note}) : assert(note != null);

  @override
  List<Object> get props => [note];
}

class EditNoteEvent extends NoteEvent {
  final NoteModel note;

  const EditNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}
