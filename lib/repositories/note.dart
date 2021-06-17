import 'package:nevis/database_model/moor_db.dart';
import 'package:nevis/database_model/util.dart';
import 'package:nevis/model/category_model.dart';
import 'package:nevis/model/note_model.dart';

class NoteRepository {
  Future<List> fetchNotes() async {
    List<NoteModel> noteList = [];
    var notes = await locator<AppDatabase>().getAllNotes();
    for (int i = 0; i < notes.length; i++) {
      print(notes[i].title);
      noteList.add(NoteModel.fromMoor(notes[i]));
    }
    return noteList;
  }

  Future<List> fetchCategoryNotes(CategoryModel category) async {
    List<NoteModel> noteList = [];
    var notes = await locator<AppDatabase>().getAllNotesByCategory(category);
    for (int i = 0; i < notes.length; i++) {
      print(notes[i].content+"aaaaaaaaaaaaaaaaaaaaaar");
      noteList.add(NoteModel.fromMoor(notes[i]));
    }
    return noteList;
  }

  Future<List> fetchCategories() async {
    List<CategoryModel> categoryList = [];
    var categories = await locator<AppDatabase>().getAllCategories();
    for (int i = 0; i < categories.length; i++) {
      print(categories[i].name);
      categoryList.add(CategoryModel.fromMoor(categories[i]));
    }
    return categoryList;
  }

  Future<bool> addCategory(CategoryModel category) async {
    await locator<AppDatabase>().insertCategory(category.toMoor());
    return true;
  }

  Future<bool> editCategory(CategoryModel category) async {
    await locator<AppDatabase>().updateCategory(category.toMoor());
    return true;
  }

  Future<bool> removeCategory(CategoryModel category) async {
    await locator<AppDatabase>().deleteCategory(category.toMoor());
    return true;
  }

  Future<bool> addNote(NoteModel note) async {
    await locator<AppDatabase>().insertNote(note.toMoor());
    return true;
  }

  Future<bool> editNote(NoteModel note) async {
    await locator<AppDatabase>().updateNote(note.toMoor());
    return true;
  }

  Future<bool> removeNote(NoteModel note) async {
    await locator<AppDatabase>().deleteNote(note.toMoor());
    return true;
  }
}
