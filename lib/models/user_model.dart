class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String profilePicture;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.profilePicture = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
      };
}
