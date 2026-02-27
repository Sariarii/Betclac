import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../database.dart';
import '../data/tournament_data.dart';
import '../data/team_data.dart';
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

  Future<void> addTeamToTournament(int tournamentId, int teamId) async {
    final db = await DatabaseHelper.instance.database;

    await db.insert(
      'tournament_teams',
      {
        'tournamentId': tournamentId,
        'teamId': teamId,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Team>> getTeamsForTournament(int tournamentId) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.rawQuery('''
      SELECT teams.id, teams.name
      FROM teams
      INNER JOIN tournament_teams
      ON teams.id = tournament_teams.teamId
      WHERE tournament_teams.tournamentId = ?
    ''', [tournamentId]);

    return result.map((map) => Team(
      id: map['id'] as int,
      name: map['name'] as String,
    )).toList();
}

}