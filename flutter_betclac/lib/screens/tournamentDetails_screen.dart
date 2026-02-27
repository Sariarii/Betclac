import 'package:flutter/material.dart';
import 'package:flutter_betclac/screens/matchDetails_screen.dart';
import '../data/tournament_data.dart';
import '../data/team_data.dart';
import '../data/match_data.dart';
import '../repositories/tournament_repository.dart';
import '../repositories/match__repository.dart';
import '../providers/team_provider.dart';
import 'package:provider/provider.dart';

class TournamentDetailsScreen extends StatefulWidget {
  final Tournament tournament;

  const TournamentDetailsScreen({super.key, required this.tournament});

  @override
  State<TournamentDetailsScreen> createState() =>
      _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {
  final TournamentRepository _tournamentRepo = TournamentRepository();
  final MatchRepository _matchRepo = MatchRepository();

  List<Team> tournamentTeams = [];
  List<Match> matches = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final teams = await _tournamentRepo.getTeamsForTournament(
      widget.tournament.id!,
    );

    final matchList = await _matchRepo.getMatchesForTournament(
      widget.tournament.id!,
    );

    setState(() {
      tournamentTeams = teams;
      matches = matchList;
      isLoading = false;
    });
  }

  void _openAddTeamModal() {
    final allTeams = context.read<TeamProvider>().teams;

    final availableTeams = allTeams
        .where((team) => !tournamentTeams.any((t) => t.id == team.id))
        .toList();

    if (availableTeams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Toutes les équipes sont déjà ajoutées")),
      );
      return;
    }

    int? selectedTeamId;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Ajouter une équipe",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  DropdownButton<int>(
                    value: selectedTeamId,
                    hint: const Text("Choisir une équipe"),
                    isExpanded: true,
                    items: availableTeams.map((team) {
                      return DropdownMenuItem(
                        value: team.id,
                        child: Text(team.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setModalState(() {
                        selectedTeamId = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: selectedTeamId == null
                        ? null
                        : () async {
                            await _tournamentRepo.addTeamToTournament(
                              widget.tournament.id!,
                              selectedTeamId!,
                            );

                            Navigator.pop(context);
                            await _loadData();
                          },
                    child: const Text("Ajouter"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _openAddMatchModal() {
    if (tournamentTeams.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Il faut au moins 2 équipes")),
      );
      return;
    }

    int? homeId;
    int? awayId;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Créer un match",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  DropdownButton<int>(
                    value: homeId,
                    hint: const Text("Équipe domicile"),
                    isExpanded: true,
                    items: tournamentTeams.map((team) {
                      return DropdownMenuItem(
                        value: team.id,
                        child: Text(team.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setModalState(() {
                        homeId = value;
                      });
                    },
                  ),

                  const SizedBox(height: 12),

                  DropdownButton<int>(
                    value: awayId,
                    hint: const Text("Équipe extérieure"),
                    isExpanded: true,
                    items: tournamentTeams.map((team) {
                      return DropdownMenuItem(
                        value: team.id,
                        child: Text(team.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setModalState(() {
                        awayId = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      if (homeId == null || awayId == null) return;

                      if (homeId == awayId) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Une équipe ne peut pas jouer contre elle-même",
                            ),
                          ),
                        );
                        return;
                      }

                      final match = Match(
                        tournamentId: widget.tournament.id!,
                        homeTeamId: homeId!,
                        awayTeamId: awayId!,
                      );

                      await _matchRepo.insertMatch(match);

                      Navigator.pop(context);
                      await _loadData();
                    },
                    child: const Text("Créer"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tournament.name)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  const Text(
                    "Équipes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ...tournamentTeams.map(
                    (team) => Card(child: ListTile(title: Text(team.name))),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Matchs",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ...matches.map((match) {
                    final home = tournamentTeams.firstWhere(
                      (t) => t.id == match.homeTeamId,
                    );

                    final away = tournamentTeams.firstWhere(
                      (t) => t.id == match.awayTeamId,
                    );

                    return Card(
                      child: ListTile(
                        trailing: SizedBox(
                          width: 50,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () async {
                                  await _matchRepo.deleteMatch(match.id!);
                                  await _loadData();
                                },
                              ),
                            ],
                          ),
                        ),
                        title: Text("${home.name} vs ${away.name}"),
                        subtitle: Text(
                          "${match.homeScore ?? '0'} - ${match.awayScore ?? '0'}",
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MatchDetailsScreen(
                                homeTeam: home.name,
                                awayTeam: away.name,
                                homeScore: match.homeScore ?? 0,
                                awayScore: match.awayScore ?? 0,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "addMatch",
            onPressed: _openAddMatchModal,
            child: const Icon(Icons.sports_soccer),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "addTeam",
            onPressed: _openAddTeamModal,
            child: const Icon(Icons.group_add),
          ),
        ],
      ),
    );
  }
}
