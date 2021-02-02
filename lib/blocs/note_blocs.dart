import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/blocs/note_events.dart';
import 'package:nevis/blocs/note_states.dart';
import 'package:nevis/model/note_model.dart';
import 'package:nevis/repositories/note.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteRepository noteRepository = NoteRepository();

  NoteBloc(this.noteRepository) : super(NoteIsEmpty());

  NoteState get initialState => NoteIsLoading();

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is ModifyNoteEvent) {
      yield ModifyNoteState(event.currentNote);
    }
    if (event is EditNoteEvent) {
      await noteRepository.editNote(event.oldNote, event.newNote);
    }
    if (event is AddNoteEvent) {
      await noteRepository.addNote(event.note);
      List<NoteModel> notes = await noteRepository.fetchNotes();
      yield NoteIsLoaded(notes);
    }
    if (event is FetchNoteEvent) {
      yield NoteIsLoading();
      try {
        List<NoteModel> notes = await noteRepository.fetchNotes();
        yield NoteIsLoaded(notes);
      } catch (_) {
        yield NoteIsNotLoaded();
      }
    }
  }
}