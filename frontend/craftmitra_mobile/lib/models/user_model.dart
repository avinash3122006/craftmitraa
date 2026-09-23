enum UserRole {
  customer,
  artisan,
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

  bool get isArtisan => role == UserRole.artisan;
}
