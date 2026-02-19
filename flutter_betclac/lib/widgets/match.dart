import 'package:flutter/material.dart';
import '../screens/matchDetails_screen.dart';
import '../data/match_data_dur.dart';
class AddMatchForm extends StatefulWidget {
  final Function(String home, String away) onAdd;

  const AddMatchForm({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<AddMatchForm> createState() => _AddMatchFormState();
}

class _AddMatchFormState extends State<AddMatchForm> {
  final homeController = TextEditingController();
  final awayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Ajouter un match",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: homeController,
            decoration: const InputDecoration(labelText: "Équipe domicile"),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: awayController,
            decoration: const InputDecoration(labelText: "Équipe extérieur"),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              if (homeController.text.isNotEmpty &&
                  awayController.text.isNotEmpty) {

                widget.onAdd(
                  homeController.text,
                  awayController.text,
                );

                Navigator.pop(context);
              }
            },
            child: const Text("Ajouter"),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final Text title;
  final Text subtitle;
  final Match match;
  final VoidCallback onDetails;

  const MatchCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.match,
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
            title, subtitle,
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => MatchDetailsScreen(
                    homeTeam: match.homeTeam,
                    awayTeam: match.awayTeam,
                    homeScore: match.homeScore ?? 0,
                    awayScore: match.awayScore ?? 0,
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
