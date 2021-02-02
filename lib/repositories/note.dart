import 'package:nevis/database_model/note_db_models.dart';
import 'package:nevis/model/note_model.dart';

class NoteRepository {
  Future<List> fetchNotes() async {
    List<NoteModel> noteList = [];
    final notes = await Note().select().orderByDesc("id").toList();
    // await Note().select().orderByDesc("id").page(page, 10).toList();
    for (int i = 0; i < notes.length; i++) {
      noteList.add(NoteModel.fromORM(notes[i]));
    }
    return noteList;
  }

  Future<int> getNotesCount() async {
    final notes = await Note().select().toList();
    return notes.length;
  }

  Future<int> getPageCount() async {
    int count = await getNotesCount();
    return (count / 10).ceil();
  }

  Future<bool> addNote(NoteModel note) async {
    Note noteDb = note.toORM();
    print(note.createdDate.toString());
    var isFinished = await noteDb.save();
    if (isFinished != null) return true;
    return false;
  }

  Future<bool> editNote(NoteModel oldNote, NoteModel newNote) async {
    var noteObject = Note();
    final noteData = await noteObject.getById(oldNote.id.toInt());
    print("new note context " + newNote.context);
    print("old note context " + oldNote.context);
    noteData.context = newNote.context;
    noteData.title = newNote.title;
    noteData.is_synced = newNote.isSynced;
    noteData.save();
    return true;
  }

  removeAll() async {
    final note = Note();
    note.select().delete(true);
    await note.save();
  }

  removeDB() {
    final note = Note();
  }
}
