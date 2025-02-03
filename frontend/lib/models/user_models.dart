// lib/models/user_model.dart
class User {
  final String username;
  final String vendorNumber;
  final String email;

  User({
    required this.username,
    required this.vendorNumber,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      vendorNumber: json['vendorNumber'],
      email: json['email'],
    );
  }
}