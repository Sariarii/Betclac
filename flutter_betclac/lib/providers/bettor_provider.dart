import 'package:flutter/material.dart';
import 'package:flutter_betclac/data/bettor_data.dart';
import '../repositories/bettor_repository.dart';

class BettorProvider extends ChangeNotifier {
  final BettorRepository _repository = BettorRepository();

  List<Bettor> _bettors = [];

  List<Bettor> get bettors => _bettors;

  Future<void> loadBettors() async {
    _bettors = await _repository.getAll();
    notifyListeners();
  }

  Future<void> addBettor(String firstName, String lastName) async {
    await _repository.insert(Bettor(firstName: firstName, lastName: lastName));
    await loadBettors();
  }
}
