
class Match {
  final String homeTeam;
  final String awayTeam;
  final int? homeScore;
  final int? awayScore;


  Match({
    this.homeScore,
    this.awayScore,
    required this.homeTeam,
    required this.awayTeam,
  });

    Map<String, Object?> toMap() {
    return {'homeScore': homeScore, 'awayScore': awayScore, 'homeTeam': homeTeam, 'awayTeam': awayTeam};
  }
}