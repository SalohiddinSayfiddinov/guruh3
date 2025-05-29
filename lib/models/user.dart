class User {
  final String id;
  final String name;
  final String avatar;
  final String createdAt;

  const User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
