import 'package:flutter/material.dart';
import '../data/tournament_data.dart';

class AddTournamentModal extends StatefulWidget {
  final Function(String name) onAdd;

  const AddTournamentModal({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  @override
  State<AddTournamentModal> createState() => _AddTournamentModalState();
}

class _AddTournamentModalState extends State<AddTournamentModal> {
  final TextEditingController _controller = TextEditingController();

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
            "Ajouter un tournoi",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: "Nom du tournoi",
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.onAdd(_controller.text);
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