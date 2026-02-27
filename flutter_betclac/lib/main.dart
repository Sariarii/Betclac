import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tournament_provider.dart';
import 'providers/team_provider.dart';
import 'providers/bettor_provider.dart';
import 'widgets/tournament.dart';
import 'widgets/modalAddTournament.dart';
import 'widgets/modalAddTeam.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'widgets/modalAddBettor.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TournamentProvider()),
        ChangeNotifierProvider(create: (_) => TeamProvider()),
        ChangeNotifierProvider(create: (_) => BettorProvider()),
      ],
      child: MaterialApp(
        title: 'Betclac',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 16, 10, 8),
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Charger les tournois au démarrage
    Future.microtask(() {
      context.read<TournamentProvider>().loadTournaments();
      context.read<TeamProvider>().loadTeams();
      context.read<BettorProvider>().loadBettors();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (selectedIndex) {
      case 0:
        page = Consumer<TournamentProvider>(
          builder: (context, provider, _) {
            if (provider.tournaments.isEmpty) {
              return const Center(child: Text("Aucun tournoi pour le moment"));
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: provider.tournaments.map((tournament) {
                return TournamentCard(
                  tournament: tournament,
                  onDetails: () {
                    print("Voir détails ${tournament.name}");
                  },
                );
              }).toList(),
            );
          },
        );
        break;
      case 1:
        page = Consumer<TeamProvider>(
          builder: (context, provider, _) {
            if (provider.teams.isEmpty) {
              return const Center(child: Text("Aucune équipe"));
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: provider.teams.map((team) {
                return Card(child: ListTile(title: Text(team.name)));
              }).toList(),
            );
          },
        );
        break;
      case 2:
        page = const Center(child: Text("Leaderboard page"));
        break;
      case 3:
        page = Consumer<BettorProvider>(
          builder: (context, provider, _) {
            if (provider.bettors.isEmpty) {
              return const Center(child: Text("Aucune parieur"));
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: provider.bettors.map((team) {
                return Card(
                  child: ListTile(
                    title: Text("${team.firstName} ${team.lastName}"),
                  ),
                );
              }).toList(),
            );
          },
        );
      default:
        page = const SizedBox();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.emoji_events),
                      label: Text('Tournaments'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.flag_circle),
                      label: Text('Teams'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.leaderboard),
                      label: Text('Leaderboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Bettor'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (selectedIndex == 0) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => AddTournamentModal(
                    onAdd: (name) async {
                      await context.read<TournamentProvider>().addTournament(
                        name,
                      );
                    },
                  ),
                );
              } else if (selectedIndex == 1) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => AddTeamModal(
                    onAdd: (name) async {
                      await context.read<TeamProvider>().addTeam(name);
                    },
                  ),
                );
              } else if (selectedIndex == 3) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => AddBettorModal(
                    onAdd: (firstName, lastName) async {
                      await context.read<BettorProvider>().addBettor(
                        firstName,
                        lastName,
                      );
                    },
                  ),
                );
              }
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
