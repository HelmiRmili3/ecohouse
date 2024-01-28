class Company {
  final int? id;
  final String name;
  final String email;

  Company({
    this.id,
    required this.name,
    required this.email,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}
