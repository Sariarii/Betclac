import 'package:flutter/material.dart';
import '../data/tournament_data.dart';
import '../repositories/tournament_repository.dart';

class TournamentProvider extends ChangeNotifier {
  final TournamentRepository _repository = TournamentRepository();

  List<Tournament> _tournaments = [];

  List<Tournament> get tournaments => _tournaments;

  Future<void> loadTournaments() async {
    _tournaments = await _repository.getAll();
    notifyListeners();
  }

  Future<void> addTournament(String name) async {
    print("Ajout tournoi: $name");
    await _repository.insert(Tournament(name: name));
    await loadTournaments();
    print("Nombre total: ${_tournaments.length}");
  }

  Future<void> addTeamToTournament(int tournamentId, int teamId) async {
    await _repository.addTeamToTournament(tournamentId, teamId);
    notifyListeners();
  }
}