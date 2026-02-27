import '../database.dart';
import '../data/bettor_data.dart';

class BettorRepository {
  Future<List<Bettor>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('bettors');

    return result
        .map(
          (map) => Bettor(
            id: map['id'] as int,
            firstName: map['firstName'] as String,
            lastName: map['lastName'] as String,
          ),
        )
        .toList();
  }

  Future<void> insert(Bettor bettor) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('bettors', bettor.toMap());
  }
}
