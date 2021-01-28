import 'package:equatable/equatable.dart';
import 'package:nevis/model/note_model.dart';

class NoteState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteIsLoading extends NoteState {}

class NoteIsLoaded extends NoteState {
  final List<NoteModel> _notes;
  NoteIsLoaded(this._notes);
  List<NoteModel> get getNotes => _notes;

  @override
  List<Object> get props => [this._notes];
}

class NoteIsAdded extends NoteState {}

class NoteIsEmpty extends NoteState {}

class NoteIsNotLoaded extends NoteState{}