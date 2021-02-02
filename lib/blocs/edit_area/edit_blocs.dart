import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/model/note_model.dart';
import 'package:nevis/repositories/note.dart';
import 'edit_events.dart';
import 'edit_states.dart';

class EditAreaBloc extends Bloc<EditAreaEvents, EditState> {
  NoteRepository noteRepository = NoteRepository();

  EditAreaBloc(this.noteRepository) : super(AddNoteState());

  EditState get initialState => AddNoteState();

  @override
  Stream<EditState> mapEventToState(EditAreaEvents event) async* {
    if (event is ModifyEvent) {
      print("modify called");
      yield ModifyState(event.currentNote);
    }
    if (event is AddEvent) {
      yield AddNoteState();
    }
  }
}
