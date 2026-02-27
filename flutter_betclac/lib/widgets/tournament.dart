import 'package:flutter/material.dart';
import '../screens/tournamentDetails_screen.dart';
import '../data/tournament_data.dart'; 
class TournamentCard extends StatelessWidget {
  final Tournament tournament;
  final VoidCallback onDetails;

  const TournamentCard({
    Key? key,
    required this.tournament,
    required this.onDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tournament.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => TournamentDetailsScreen(
                    tournament: tournament,
                    ),
                  ),
                );
              },
              child: const Text("Détails"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
