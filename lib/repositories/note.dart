import 'package:nevis/database_model/moor_db.dart';
import 'package:nevis/database_model/util.dart';
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

    // var dbHelper = Helper();
    // return dbHelper.getAllUsers();

    // List<NoteModel> noteList = [];
    // final notes = await Note().select().orderByDesc("id").toList();
    // // await Note().select().orderByDesc("id").page(page, 10).toList();
    // for (int i = 0; i < notes.length; i++) {
    //   noteList.add(NoteModel.fromMap(notes[i]));
    // }
    // return noteList;
  }

  // Future<int> getNotesCount() async {
  //   final notes = await Note().select().toList();
  //   return notes.length;
  // }
  //
  // Future<int> getPageCount() async {
  //   int count = await getNotesCount();
  //   return (count / 10).ceil();
  // }

  Future<bool> addNote(NoteModel note) async {
    await locator<AppDatabase>().insertNote(note.toMoor());
    return true;
    // var dbHelper = Helper();
    // note.title = "default";
    // note.isSynced = 1;
    // dbHelper.insert(note);
    //
    // return true;
    // Note noteDb = note.toORM();
    // var isFinished = await noteDb.save();
    // if (isFinished != null) return true;
    // return false;
  }

  Future<bool> editNote(NoteModel oldNote, NoteModel newNote) async {
    // var dbHelper = Helper();
    // // dbHelper.update(note);
    // return true;
    // var noteObject = Note();
    // final noteData = await noteObject.getById(oldNote.id.toInt());
    // noteData.context = newNote.context;
    // noteData.title = newNote.title;
    // noteData.is_synced = newNote.isSynced;
    // noteData.save();
    // return true;
  }

  Future<bool> removeNote(NoteModel note) async {
    // var dbHelper = Helper();
    // dbHelper.deleteNote(note.id);
    // return true;
    return true;
  }
}
