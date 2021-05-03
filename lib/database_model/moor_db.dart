import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
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

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1)();

  TextColumn get content => text()();

  DateTimeColumn get dateAdded => dateTime().nullable()();

  DateTimeColumn get dateSynced => dateTime().nullable()();

  BoolColumn get synced => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<Note>> getAllNotes() {
    print("get all notes called");
    return (select(notes)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.dateAdded, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future<int> insertNote(Note note) => into(notes).insert(note);

  Future<int> deleteNote(Note note) => delete(notes).delete(note);
}
