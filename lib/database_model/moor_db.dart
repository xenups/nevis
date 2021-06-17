import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:nevis/model/category_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'moor_db.g.dart';

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    print(file.path.toString());
    return VmDatabase(file);
  });
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();
}

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get category => integer()
      .nullable()
      .customConstraint('NULL REFERENCES categories(id) ON DELETE CASCADE')();

  TextColumn get title => text().withLength(min: 1)();

  TextColumn get content => text()();

  DateTimeColumn get dateAdded => dateTime().nullable()();

  DateTimeColumn get dateSynced => dateTime().nullable()();

  BoolColumn get synced => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Notes, Categories])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<Note>> getAllNotes() {
    return (select(notes)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.dateAdded, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future<List<Note>> getAllNotesByCategory(CategoryModel category) {

    final _select =select(notes);
    // _select..where((tbl) => tbl.category.$name)
    return (select(notes)
          ..where((tbl) => tbl.category.equals(category.id))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.dateAdded, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future<List<Categorie>> getAllCategories() {
    return (select(categories)
          ..orderBy(
              [(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
        .get();
  }

  Future<int> insertCategory(Categorie categorie) =>
      into(categories).insert(categorie);

  Future updateCategory(Categorie categorie) =>
      update(categories).replace(categorie);

  Future<int> deleteCategory(Categorie categorie) =>
      delete(categories).delete(categorie);

  Future<int> insertNote(Note note) => into(notes).insert(note);

  Future updateNote(Note note) => update(notes).replace(note);

  Future<int> deleteNote(Note note) => delete(notes).delete(note);
}
