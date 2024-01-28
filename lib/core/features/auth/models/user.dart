
class UserModule {
  final String id;
  final String imageUrl;
  final String name;
  final String email;
  final int credit;
  UserModule({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.email,
    required this.credit,
  });

  factory UserModule.fromJson(Map<String, dynamic> json) {
    // List<OrderModule> orders = (json['orders'] as List)
    //     .map((ordersJson) => OrderModule.fromJson(ordersJson))
    //     .toList();

    return UserModule(
      id: json["id"],
      name: json["name"],
      imageUrl: json["imageUrl"],
      email: json["email"],
      credit: json["credit"],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'name': name,
        'email': email,
        'credit': credit,
      };
}
