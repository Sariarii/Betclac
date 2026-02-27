import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('betclac_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tournaments(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');
      await db.execute('''
    CREATE TABLE teams(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    )
  ''');

  await db.execute('''
    CREATE TABLE matches(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      tournamentId INTEGER NOT NULL,
      homeTeamId INTEGER NOT NULL,
      awayTeamId INTEGER NOT NULL,
      homeScore INTEGER,
      awayScore INTEGER,
      FOREIGN KEY (tournamentId) REFERENCES tournaments(id),
      FOREIGN KEY (homeTeamId) REFERENCES teams(id),
      FOREIGN KEY (awayTeamId) REFERENCES teams(id)
    )
      ''');
    await db.execute('''
      CREATE TABLE tournament_teams(
      tournamentId INTEGER NOT NULL,
      teamId INTEGER NOT NULL,
      PRIMARY KEY (tournamentId, teamId),
      FOREIGN KEY (tournamentId) REFERENCES tournaments(id),
      FOREIGN KEY (teamId) REFERENCES teams(id)
    )
      ''');
  }
}


