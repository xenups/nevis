import 'package:jiffy/jiffy.dart';
import 'package:nevis/database_model/note_db_models.dart';

class NoteModel {
  int id;
  int totalPages;
  String title;
  String context;
  bool isSynced;
  DateTime createdDate;
  String daysAgo;

  NoteModel(
      {this.id,
      this.title,
      this.context,
      this.isSynced,
      this.createdDate,
      this.daysAgo,
      this.totalPages});

  NoteModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.title = json["title"];
    this.context = json["context"];
    this.isSynced = json["is_synced"];
    this.createdDate = json["created_date"];
    this.daysAgo = Jiffy(createdDate).fromNow();
  }

  Future<int> getNoteCount() async {
    Note _note = Note();
    List _listNote = await _note.select().toList();
    return _listNote.length;
  }

  NoteModel.fromORM(Note note) {
    this.id = note.id;
    this.title = note.title;
    this.context = note.context;
    this.isSynced = note.is_synced;
    this.createdDate = note.created_date;
    this.daysAgo = Jiffy(createdDate).fromNow();
  }

  Note toORM() {
    Note note = Note();
    note.title = this.title;
    note.context = this.context;
    // note.created_date = this.createdDate;
    note.is_synced = this.isSynced;
    return note;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json["id"] = this.id.toString();
    json["title"] = this.title;
    json["context"] = this.context;
    json["is_synced"] = this.isSynced;
    json["created_date"] = this.createdDate;
    return json;
  }
}

class NoteListModel {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<NoteModel> data;

  NoteListModel(
      {this.page, this.perPage, this.total, this.totalPages, this.data});

  NoteListModel.fromJson(Map<String, dynamic> json) {
    this.page = json["page"];
    this.perPage = json["per_page"];
    this.total = json["total"];
    this.totalPages = json["total_pages"];
    this.data = List<NoteModel>();
    json["data"].forEach((note) {
      this.data.add(new NoteModel.fromJson(note));
    });
  }

  NoteListModel.fromORM(List<Note> notes) {
    this.perPage = 10;
    for (int i = 0; i < notes.length; i++) {
      this.data.add(NoteModel.fromORM(notes[i]));
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json["page"] = this.page;
    json["per_page"] = this.perPage;
    json["total"] = this.total;
    json["total_pages"] = this.totalPages;
    json["data"] = this.data.map((e) => e.toJson()).toList();
    return json;
  }
}
