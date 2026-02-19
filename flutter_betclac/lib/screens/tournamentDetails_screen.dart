import 'package:flutter/material.dart';
import '../widgets/match.dart';
import '../widgets/tournament.dart';
import '../data/match_data_dur.dart';
class TournamentDetailsScreen extends StatefulWidget {
  final String tournamentName;

  const TournamentDetailsScreen({
    Key? key,
    required this.tournamentName,
  }) : super(key: key);

   @override
  State<TournamentDetailsScreen> createState() =>
      _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState
    extends State<TournamentDetailsScreen> {

  List<Match> matches = [
  Match(
    homeTeam: "France",
    awayTeam: "Allemagne",
    homeScore: 2,
    awayScore: 1,
  ),
  Match(
    homeTeam: "Espagne",
    awayTeam: "France",
    homeScore: 0,
    awayScore: 0,
  ),
];

  @override
  Widget build(BuildContext context) {
    final standings = [
      {"team": "France", "points": 6},
      {"team": "Allemagne", "points": 3},
      {"team": "Espagne", "points": 1},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tournamentName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // CLASSEMENT
            const Text(
              "Classement",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            ...standings.map((team) => ListTile(
                  leading: const Icon(Icons.emoji_events),
                  title: Text(team["team"] as String),
                  trailing: Text("${team["points"]} pts"),
                )),

            const SizedBox(height: 30),

            // MATCHS
            const Text(
              "Matchs",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            ...matches.map((match) => MatchCard(            
            title: Text("${match.homeTeam} vs ${match.awayTeam}"),
            subtitle:Text("${match.homeScore} - ${match.awayScore}"),
            match: match,
            onDetails: () {
              print("Voir détails");
            },
            ),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
              builder: (_) => AddMatchForm(
                onAdd: (home, away) {
                  setState(() {
                  matches.add(
                    Match(
                      homeTeam: home,
                      awayTeam: away,
                      homeScore: 0,
                      awayScore: 0,
                    ),
                  );
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
