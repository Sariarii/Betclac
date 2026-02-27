class Tournament {
  final int? id;
  final String name;

  Tournament({this.id,required this.name});

    Map<String, Object?> toMap() {
    return {'id': id, 'name': name};
  }
}