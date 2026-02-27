import 'package:flutter/material.dart';
import '../data/team_data.dart';
import '../repositories/team__repository.dart';

class TeamProvider extends ChangeNotifier {
  final TeamRepository _repository = TeamRepository();

  List<Team> _teams = [];

  List<Team> get teams => _teams;

  Future<void> loadTeams() async {
    _teams = await _repository.getAll();
    notifyListeners();
  }

  Future<void> addTeam(String name) async {
    await _repository.insert(Team(name: name));
    await loadTeams();
  }
}