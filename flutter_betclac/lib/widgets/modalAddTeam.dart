import 'package:flutter/material.dart';

class AddTeamModal extends StatefulWidget {
  final Function(String name) onAdd;

  const AddTeamModal({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddTeamModal> createState() => _AddTeamModalState();
}

class _AddTeamModalState extends State<AddTeamModal> {
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
            "Ajouter une équipe",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: "Nom de l'équipe",
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