import 'package:equatable/equatable.dart';
import 'package:nevis/model/note_model.dart';

class EditState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddNoteState extends EditState {}

class ModifyState extends EditState {
  final NoteModel _note;

  ModifyState(this._note);

  NoteModel get getNote => _note;

  @override
  List<Object> get props => [this._note];
}
