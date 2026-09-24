class ArtisanModel {
  final String id;
  final String name;
  final String craftType;
  final String village;
  final String state;
  final String bio;
  final int yearsOfExperience;
  final double rating;
  final int reviewCount;
  final bool isVerified;
  final String avatarUrl;
  final String coverImageUrl;
  final List<String> awards;
  final String audioStoryTitle;
  final int audioDurationSeconds;
  final int productsCount;

  ArtisanModel({
    required this.id,
    required this.name,
    required this.craftType,
    required this.village,
    required this.state,
    required this.bio,
    this.yearsOfExperience = 12,
    this.rating = 4.9,
    this.reviewCount = 124,
    this.isVerified = true,
    required this.avatarUrl,
    required this.coverImageUrl,
    this.awards = const [],
    this.audioStoryTitle = 'Heritage Craft Story',
    this.audioDurationSeconds = 145,
    this.productsCount = 18,
  });

  factory ArtisanModel.fromApiJson(Map<String, dynamic> json) {
    final awardsRaw = json['awards'];
    final awards = <String>[];

    if (awardsRaw is String && awardsRaw.trim().isNotEmpty) {
      awards.addAll(awardsRaw.split(',').map((value) => value.trim()).where((value) => value.isNotEmpty));
    } else if (awardsRaw is List) {
      awards.addAll(awardsRaw.map((value) => value.toString()).where((value) => value.isNotEmpty));
    }

    return ArtisanModel(
      id: (json['id'] ?? '').toString(),
      name: (json['business_name'] ?? json['name'] ?? 'Craft Artisan').toString(),
      craftType: (json['craft_type'] ?? 'Handcrafted Art').toString(),
      village: (json['village'] ?? '').toString(),
      state: (json['state'] ?? '').toString(),
      bio: (json['bio'] ?? '').toString(),
      yearsOfExperience: int.tryParse((json['years_of_experience'] ?? '0').toString()) ?? 0,
      rating: double.tryParse((json['rating'] ?? '0').toString()) ?? 0.0,
      reviewCount: int.tryParse((json['review_count'] ?? '0').toString()) ?? 0,
      isVerified: json['is_verified'] is bool ? json['is_verified'] as bool : true,
      avatarUrl: (json['avatar_url'] ?? 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80').toString(),
      coverImageUrl: (json['cover_image_url'] ?? json['avatar_url'] ?? 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80').toString(),
      awards: awards,
      audioStoryTitle: 'Heritage Craft Story',
      audioDurationSeconds: 145,
      productsCount: 0,
    );
  }

  String get fullLocation => '$village, $state';
}
