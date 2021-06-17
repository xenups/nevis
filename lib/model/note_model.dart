import 'package:jiffy/jiffy.dart';
import 'package:nevis/database_model/moor_db.dart';
import 'package:nevis/model/category_model.dart';

class NoteModel {
  int id;
  int totalPages;
  String title;
  String context;
  bool isSynced;
  DateTime createdDate;
  String daysAgo;
  int category;

  NoteModel(
      {this.id,
      this.title,
      this.context,
      this.isSynced,
      this.createdDate,
      this.daysAgo,
      this.totalPages,
      this.category});

  NoteModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.title = json["title"];
    this.context = json["context"];
    this.isSynced = json["is_synced"];
    this.createdDate = json["created_date"];
    this.category = json["category"];
    this.daysAgo = Jiffy(createdDate).fromNow();
  }

  NoteModel.fromMoor(Note note) {
    this.id = note.id;
    this.title = note.title;
    this.context = note.content;
    this.isSynced = note.synced;
    this.createdDate = note.dateAdded;
    this.category = note.category;
    this.daysAgo = Jiffy(createdDate).fromNow();
  }

  Note toMoor() {
    return Note(
        id: this.id,
        title: this.title,
        content: this.context,
        synced: this.isSynced,
        dateAdded: this.createdDate,
        category: this.category,
        dateSynced: this.createdDate);
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
