import 'package:flutter/material.dart';
import '../data/team_data.dart';
import '../providers/tournament_provider.dart';
import 'package:provider/provider.dart';

class AddTeamToTournamentModal extends StatefulWidget {
  final int tournamentId;
  final List<Team> allTeams;

  const AddTeamToTournamentModal({
    super.key,
    required this.tournamentId,
    required this.allTeams,
  });

  @override
  State<AddTeamToTournamentModal> createState() =>
      _AddTeamToTournamentModalState();
}

class _AddTeamToTournamentModalState extends State<AddTeamToTournamentModal> {
  int? selectedTeamId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Ajouter une équipe au tournoi",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          DropdownButton<int>(
            value: selectedTeamId,
            hint: const Text("Choisir une équipe"),
            isExpanded: true,
            items: widget.allTeams.map((team) {
              return DropdownMenuItem(value: team.id, child: Text(team.name));
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedTeamId = value;
              });
            },
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: selectedTeamId == null
                ? null
                : () async {
                    await context
                        .read<TournamentProvider>()
                        .addTeamToTournament(
                          widget.tournamentId,
                          selectedTeamId!,
                        );

                    Navigator.pop(context);
                  },
            child: const Text("Ajouter"),
          ),
        ],
      ),
    );
  }
}
