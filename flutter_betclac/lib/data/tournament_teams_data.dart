class TournamentTeams {
  final int tournamentId;
  final int teamId;

  TournamentTeams({required this.tournamentId,required this.teamId});

    Map<String, Object?> toMap() {
    return {'tournamentId': tournamentId, 'teamId': teamId};
  }
}