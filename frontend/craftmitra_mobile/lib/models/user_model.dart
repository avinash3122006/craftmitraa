enum UserRole {
  customer,
  artisan,
}

extension UserRoleX on UserRole {
  static UserRole fromApiValue(String? value) {
    switch ((value ?? '').toLowerCase()) {
      case 'artisan':
        return UserRole.artisan;
      case 'customer':
      default:
        return UserRole.customer;
    }
  }

  String get apiValue => name;
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final String avatarUrl;
  final String location;
  final String? craftSpecialty;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.avatarUrl = 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
    this.location = 'Jaipur, Rajasthan',
    this.craftSpecialty,
  });

  factory UserModel.fromApiJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? 'User').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      role: UserRoleX.fromApiValue(json['role']?.toString()),
      location: (json['location'] ?? 'Jaipur, Rajasthan').toString(),
      avatarUrl: (json['avatar_url'] ?? json['avatarUrl'] ?? 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80').toString(),
      craftSpecialty: json['craft_specialty']?.toString() ?? json['craftSpecialty']?.toString(),
    );
  }

  bool get isArtisan => role == UserRole.artisan;
}
