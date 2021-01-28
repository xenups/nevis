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
    if(event is AddNoteEvent){
      await noteRepository.addNote(event.note);
      List<NoteModel> notes = await noteRepository.fetchNotes();
      yield NoteIsLoaded(notes);

      try{}catch(_){}
    }
    if (event is FetchNoteEvent) {
      yield NoteIsLoading();
      try {
        print("loadgin notes");
        List<NoteModel> notes = await noteRepository.fetchNotes();
        yield NoteIsLoaded(notes);
      } catch (_) {print("error");
        yield NoteIsNotLoaded();
      }
    }
  }
}
