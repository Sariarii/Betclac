import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tournament_provider.dart';
import 'widgets/tournament.dart';
import 'widgets/modalAddTournament.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

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
        ChangeNotifierProvider(
          create: (_) => TournamentProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Betclac',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
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
              return const Center(
                child: Text("Aucun tournoi pour le moment"),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: provider.tournaments.map((tournament) {
                return TournamentCard(
                  title: tournament.name,
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
        page = const Center(child: Text("Teams page"));
        break;

      case 2:
        page = const Center(child: Text("Leaderboard page"));
        break;

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
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
          floatingActionButton: selectedIndex == 0
              ? FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => AddTournamentModal(
                        onAdd: (name) async {
                          await context
                              .read<TournamentProvider>()
                              .addTournament(name);
                        },
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}