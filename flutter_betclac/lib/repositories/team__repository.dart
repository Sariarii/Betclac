import '../database.dart';
import '../data/team_data.dart';
class TeamRepository {

  Future<List<Team>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('teams');

    return result.map((map) => Team(
      id: map['id'] as int,
      name: map['name'] as String,
    )).toList();
  }

  Future<void> insert(Team team) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'teams',
      team.toMap(),
    );
  }
}