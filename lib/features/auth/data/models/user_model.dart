class UserModel {
  final String id;
  final String phone;
  final String name;

  const UserModel({
    required this.id,
    required this.phone,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
    };
  }
}
