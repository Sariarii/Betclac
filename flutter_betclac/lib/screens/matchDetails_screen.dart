import 'package:flutter/material.dart';

class MatchDetailsScreen extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;

  const MatchDetailsScreen({
    Key? key,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bets = [
      {"bettor": "Lucas", "prediction": "2 - 1"},
      {"bettor": "Emma", "prediction": "1 - 1"},
      {"bettor": "Noah", "prediction": "0 - 3"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails du match"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // MATCH INFO
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "$homeTeam vs $awayTeam",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "$homeScore - $awayScore",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // LISTE DES PARIS
            const Text(
              "Paris",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: bets.map((bet) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(bet["bettor"] as String),
                      trailing: Text(bet["prediction"] as String),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
