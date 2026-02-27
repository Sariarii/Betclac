import '../data/match_data.dart';
import '../database.dart';

class MatchRepository {
  Future<void> insertMatch(Match match) async {
    final db = await DatabaseHelper.instance.database;

    await db.insert('matches', match.toMap());
  }

  Future<List<Match>> getMatchesForTournament(int tournamentId) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      'matches',
      where: 'tournamentId = ?',
      whereArgs: [tournamentId],
    );

    return result
        .map(
          (map) => Match(
            id: map['id'] as int,
            tournamentId: map['tournamentId'] as int,
            homeTeamId: map['homeTeamId'] as int,
            awayTeamId: map['awayTeamId'] as int,
            homeScore: map['homeScore'] as int?,
            awayScore: map['awayScore'] as int?,
          ),
        )
        .toList();
  }

  Future<void> deleteMatch(int matchId) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('matches', where: 'id = ?', whereArgs: [matchId]);
  }
}
