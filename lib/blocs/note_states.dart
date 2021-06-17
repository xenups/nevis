import 'package:equatable/equatable.dart';
import 'package:nevis/model/category_model.dart';
import 'package:nevis/model/note_model.dart';

class NoteState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteIsLoading extends NoteState {}

class NoteIsLoaded extends NoteState {
  final List<NoteModel> _notes;
  final List<CategoryModel> _categories;

  NoteIsLoaded(this._notes, this._categories);

  List<NoteModel> get getNotes => _notes;

  List<CategoryModel> get getCategories => _categories;

  @override
  List<Object> get props => [this._notes, this._categories];
}

class CategoryIsLoaded extends NoteState {
  final List<CategoryModel> _categories;

  CategoryIsLoaded(this._categories);

  List<CategoryModel> get getCategories => _categories;

  @override
  List<Object> get props => [this._categories];
}

class NoteIsAdded extends NoteState {}

class NoteIsEmpty extends NoteState {}

class NoteIsNotLoaded extends NoteState {}

class AddNote extends NoteState {}

class NoteIsDeleted extends NoteState {}

class ModifyNoteState extends NoteState {
  final NoteModel _note;

  ModifyNoteState(this._note);

  NoteModel get getNote => _note;

  @override
  List<Object> get props => [this._note];
}
