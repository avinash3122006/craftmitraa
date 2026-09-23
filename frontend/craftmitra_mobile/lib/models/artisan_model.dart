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

  String get fullLocation => '$village, $state';
}
