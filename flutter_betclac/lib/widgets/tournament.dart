import 'package:flutter/material.dart';

class TournamentCard extends StatelessWidget {
  final String title;
  final VoidCallback onDetails;

  const TournamentCard({
    Key? key,
    required this.title,
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
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: onDetails,
                child: const Text("Détails"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
