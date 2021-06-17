import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/blocs/note_events.dart';
import 'package:nevis/blocs/note_states.dart';
import 'package:nevis/model/category_model.dart';
import 'package:nevis/model/note_model.dart';
import 'package:nevis/repositories/note.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteRepository noteRepository = NoteRepository();

  NoteBloc(this.noteRepository) : super(NoteIsEmpty());

  NoteState get initialState => NoteIsLoading();

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is DeleteNoteEvent) {
      CategoryModel category = CategoryModel();
      category.name = "jadid";
      await noteRepository.removeNote(event.note);
      List<NoteModel> notes = await noteRepository.fetchNotes();
      List<CategoryModel> categories = await noteRepository.fetchCategories();
      yield NoteIsLoaded(notes, categories);
    }
    if (event is EditNoteEvent) {
      CategoryModel category = CategoryModel();
      category.name = "jadid";
      await noteRepository.editNote(event.note);
      List<NoteModel> notes = await noteRepository.fetchNotes();
      List<CategoryModel> categories = await noteRepository.fetchCategories();
      yield NoteIsLoaded(notes, categories);
    }
    if (event is AddNoteEvent) {
      CategoryModel category = CategoryModel();
      category.name = "jadid2";
      await noteRepository.addCategory(category);

      await noteRepository.addNote(event.note);
      List<NoteModel> notes = await noteRepository.fetchNotes();
      List<CategoryModel> categories = await noteRepository.fetchCategories();
      yield NoteIsLoaded(notes, categories);
    }
    if (event is FetchNoteEvent) {
      yield NoteIsLoading();
      try {
        CategoryModel category = event.category;
        if (category == null) {
          List<NoteModel> notes = await noteRepository.fetchNotes();
          List<CategoryModel> categories =
              await noteRepository.fetchCategories();
          yield NoteIsLoaded(notes, categories);
        } else {
          List<NoteModel> notes =
              await noteRepository.fetchCategoryNotes(event.category);
          print("note selected isssssss");
          print(category.name);
          notes.forEach((note) {print(note.context);});
          List<CategoryModel> categories =
              await noteRepository.fetchCategories();
          yield NoteIsLoaded(notes, categories);
        }
      } catch (_) {
        print("daste billll");
        yield NoteIsNotLoaded();
      }
    }
    if (event is ChangeCategoryEvent) {}
  }
}
