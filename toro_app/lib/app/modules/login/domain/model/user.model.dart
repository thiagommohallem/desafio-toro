class User {
  final String name;
  String id;

  User(
    this.name,
    this.id,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    User user = User(json['name'], json['id']);
    return user;
  }
}
