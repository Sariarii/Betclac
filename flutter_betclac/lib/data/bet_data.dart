class Bet {
  final int id;
  final int bettorId;
  final int matchId;
  final int predictedHomeScore;
  final int predictedAwayScore;

  Bet({
    required this.id,
    required this.bettorId,
    required this.matchId,
    required this.predictedHomeScore,
    required this.predictedAwayScore,
  });

      Map<String, Object?> toMap() {
    return {'id': id, 'bettorId': bettorId, 'matchId': matchId, 'predictedHomeScore': predictedHomeScore, 'predictedAwayScore': predictedAwayScore};
  }
}