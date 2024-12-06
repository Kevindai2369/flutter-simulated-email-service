class User {
  final String id;
  final String name;
  final String email;
  final String profilePictureUrl;
  final bool isVerified;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
    required this.isVerified,
  });

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'isVerified': isVerified,
    };
  }

  // Create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePictureUrl: json['profilePictureUrl'],
      isVerified: json['isVerified'],
    );
  }
}
