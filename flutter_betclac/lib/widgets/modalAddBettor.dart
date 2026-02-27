import 'package:flutter/material.dart';

class AddBettorModal extends StatefulWidget {
  final Function(String firstName, String lastName) onAdd;

  const AddBettorModal({super.key, required this.onAdd});

  @override
  State<AddBettorModal> createState() => _AddBettorModalState();
}

class _AddBettorModalState extends State<AddBettorModal> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

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
            "Ajouter un parieur",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: "Prénom"),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: "Nom"),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              final firstName = _firstNameController.text.trim();
              final lastName = _lastNameController.text.trim();

              if (firstName.isEmpty || lastName.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Veuillez remplir prénom et nom"),
                  ),
                );
                return;
              }

              widget.onAdd(firstName, lastName);
              Navigator.pop(context);
            },
            child: const Text("Ajouter"),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
