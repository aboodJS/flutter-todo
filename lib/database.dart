import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Task {
  final int id;
  final String title;

  const Task(this.id, this.title);

  Map<String, Object?> toMap() {
    return {'id': id, 'title': title};
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title}';
  }
}

class Database {
  Future<void> openDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),

      version: 1,

      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE Tasks(id INTEGER PRIMARY KEY, title TEXT)',
        );
      },
    );

    Future<void> insertDog(Task task) async {
      // Get a reference to the database.
      final db = await database;

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'dogs',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
