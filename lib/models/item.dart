class ItemModule {
  final int? id;
  final String name;
  final int weight;
  final int points;

  ItemModule({
    required this.id,
    required this.name,
    required this.weight,
    required this.points,
  });

  factory ItemModule.fromJson(Map<String, dynamic> json) => ItemModule(
        id: json["id"],
        name: json["name"],
        weight: json["weight"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'weight': weight, 'points': points};

  // Implement copyWith method to create a new instance with updated values
  ItemModule copyWith({
    int? id,
    String? name,
    int? weight,
    int? points,
  }) {
    return ItemModule(
      id: id ?? this.id,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      points: points ?? this.points,
    );
  }
}
