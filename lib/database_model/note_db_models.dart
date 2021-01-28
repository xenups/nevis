import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'note_db_models.g.dart';

const tableNote = SqfEntityTable(
    tableName: 'notes',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: false,
    fields: [
      SqfEntityField('title', DbType.text),
      SqfEntityField('context', DbType.text),
      SqfEntityField('is_synced', DbType.bool, defaultValue: false),
      SqfEntityField('created_date', DbType.datetime,
          defaultValue: "DateTime.now()")
    ]);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyDbModel',
    databaseName: 'sampleORM.db',
    databaseTables: [tableNote],
    sequences: [seqIdentity],
    bundledDatabasePath: null);
