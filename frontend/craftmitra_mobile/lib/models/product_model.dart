class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? originalPrice;
  final String artisanId;
  final String artisanName;
  final String artisanLocation;
  final String artisanAvatar;
  final double rating;
  final int reviewsCount;
  final String description;
  final String culturalStory;
  final List<String> materials;
  final String dimensions;
  final String weight;
  final int timeToCreateHours;
  final bool isVerifiedCraft;
  final bool isSustainable;
  final int stockQuantity;
  final List<String> images;
  final List<String> tags;
  final double fairPriceMin;
  final double fairPriceMax;
  final double artisanSharePercent;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.artisanId,
    required this.artisanName,
    required this.artisanLocation,
    required this.artisanAvatar,
    this.rating = 4.8,
    this.reviewsCount = 42,
    required this.description,
    required this.culturalStory,
    required this.materials,
    this.dimensions = '24 x 18 x 18 cm',
    this.weight = '1.2 kg',
    this.timeToCreateHours = 14,
    this.isVerifiedCraft = true,
    this.isSustainable = true,
    this.stockQuantity = 5,
    required this.images,
    required this.tags,
    required this.fairPriceMin,
    required this.fairPriceMax,
    this.artisanSharePercent = 85.0,
  });

  double get directArtisanEarning => (price * artisanSharePercent) / 100;
  String get displayPrice => '₹${price.toStringAsFixed(0)}';
  String get displayOriginalPrice => originalPrice != null ? '₹${originalPrice!.toStringAsFixed(0)}' : '';
}
