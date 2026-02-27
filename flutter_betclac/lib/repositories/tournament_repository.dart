import '../database.dart';
import '../data/tournament_data.dart';

class TournamentRepository {
  Future<List<Tournament>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('tournaments');

    return result.map((map) => Tournament(
      id: map['id'] as int,
      name: map['name'] as String,
    )).toList();
  }

  Future<void> insert(Tournament tournament) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'tournaments',
      tournament.toMap(),
    );
  }
}