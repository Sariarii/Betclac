class Bettor {
  final int? id;
  final String firstName;
  final String lastName;

  Bettor({this.id, required this.firstName, required this.lastName});

  Map<String, Object?> toMap() {
    return {'id': id, 'firstName': firstName, 'lastName': lastName};
  }
}
