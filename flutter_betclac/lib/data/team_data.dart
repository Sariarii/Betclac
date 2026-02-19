class Team{
  final int id;
  final String name;

  Team({required this.id,required this.name});

    Map<String, Object?> toMap() {
    return {'id': id, 'name': name};
  }
}