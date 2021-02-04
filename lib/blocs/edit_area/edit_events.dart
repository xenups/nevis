import 'package:equatable/equatable.dart';
import 'package:nevis/model/note_model.dart';

abstract class EditAreaEvents extends Equatable {
  const EditAreaEvents();

  @override
  List<Object> get props => [];
}

class AddEvent extends EditAreaEvents {}

class ModifyEvent extends EditAreaEvents {
  final NoteModel currentNote;

  const ModifyEvent(this.currentNote);

  @override
  List<Object> get props => [currentNote];
}
