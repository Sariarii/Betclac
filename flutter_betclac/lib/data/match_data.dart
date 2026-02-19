
class Match {
  final int id;
  final int tournamentId;
  final int homeTeamId;
  final int awayTeamId;
  final int? homeScore;
  final int? awayScore;


  Match({
    required this.id,
    required this.tournamentId,
    this.homeScore,
    this.awayScore,
    required this.homeTeamId,
    required this.awayTeamId,
  });

    Map<String, Object?> toMap() {
    return {'id': id, 'tournamentId': tournamentId, 'homeScore': homeScore, 'awayScore': awayScore, 'homeTeamId': homeTeamId, 'awayTeamId': awayTeamId};
  }
}