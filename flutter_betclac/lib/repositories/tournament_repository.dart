import 'package:sqflite/sqflite.dart';
import '../data/tournament_data.dart';
import '../database.dart';
Future<void> insertTournament(Tournament tournament) async {
  final db = await DatabaseHelper.instance.database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'tournaments',
    tournament.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}