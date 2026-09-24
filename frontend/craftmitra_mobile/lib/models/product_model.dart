import 'artisan_model.dart';

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

  factory ProductModel.fromApiJson(Map<String, dynamic> json,
      {ArtisanModel? artisan}) {
    final artisanInfo = artisan ??
        ArtisanModel(
          id: (json['artisan_id'] ?? '').toString(),
          name: 'Craft Artisan',
          craftType: 'Handcrafted Art',
          village: '',
          state: '',
          bio: '',
          avatarUrl:
              'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
          coverImageUrl:
              'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80',
        );

    final imageList = <String>[];
    final imagesRaw = json['images'];
    if (imagesRaw is List) {
      for (final item in imagesRaw) {
        if (item is Map) {
          final url = item['image_url'] ?? item['url'];
          if (url != null && url.toString().isNotEmpty) {
            imageList.add(url.toString());
          }
        } else if (item is String && item.isNotEmpty) {
          imageList.add(item);
        }
      }
    }
    if (imageList.isEmpty) {
      imageList.add(
          'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80');
    }

    final materials = <String>[];
    final materialRaw = json['material'];
    if (materialRaw is String && materialRaw.trim().isNotEmpty) {
      materials.add(materialRaw.trim());
    }
    if (json['materials'] is List) {
      for (final item in json['materials']) {
        if (item != null && item.toString().trim().isNotEmpty) {
          materials.add(item.toString());
        }
      }
    }
    if (materials.isEmpty && json['category'] != null) {
      materials.add(json['category'].toString());
    }

    final tags = <String>[];
    final tagsRaw = json['tags'];
    if (tagsRaw is List) {
      for (final item in tagsRaw) {
        if (item != null && item.toString().trim().isNotEmpty) {
          tags.add(item.toString());
        }
      }
    }
    if (tags.isEmpty) {
      tags.add(json['category']?.toString() ?? 'Handcrafted');
      if (materials.isNotEmpty) {
        tags.add(materials.first);
      }
    }

    final locationText = artisanInfo.fullLocation.isNotEmpty
        ? artisanInfo.fullLocation
        : (json['artisan_location'] ?? 'India').toString();

    return ProductModel(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? 'Craft Product').toString(),
      category: (json['category'] ?? 'Handcrafted').toString(),
      price: double.tryParse((json['price'] ?? '0').toString()) ?? 0.0,
      originalPrice: json['original_price'] == null
          ? null
          : double.tryParse(json['original_price'].toString()),
      artisanId: (json['artisan_id'] ?? artisanInfo.id).toString(),
      artisanName: artisanInfo.name,
      artisanLocation: locationText,
      artisanAvatar: artisanInfo.avatarUrl,
      rating: double.tryParse((json['rating'] ?? '4.8').toString()) ?? 4.8,
      reviewsCount: int.tryParse((json['review_count'] ?? '0').toString()) ?? 0,
      description: (json['description'] ?? '').toString(),
      culturalStory: (json['cultural_story'] ?? '').toString(),
      materials: materials,
      dimensions: (json['dimensions'] ?? '24 x 18 x 18 cm').toString(),
      weight: (json['weight'] ?? '1.2 kg').toString(),
      timeToCreateHours:
          int.tryParse((json['time_to_create_hours'] ?? '14').toString()) ?? 14,
      isVerifiedCraft: json['is_verified_craft'] is bool
          ? json['is_verified_craft'] as bool
          : true,
      isSustainable: json['is_sustainable'] is bool
          ? json['is_sustainable'] as bool
          : true,
      stockQuantity:
          int.tryParse((json['stock_quantity'] ?? '5').toString()) ?? 5,
      images: imageList,
      tags: tags,
      fairPriceMin:
          double.tryParse((json['fair_price_min'] ?? '0').toString()) ?? 0.0,
      fairPriceMax:
          double.tryParse((json['fair_price_max'] ?? '0').toString()) ?? 0.0,
      artisanSharePercent: double.tryParse(
              (json['artisan_share_percent'] ?? '85.0').toString()) ??
          85.0,
    );
  }

  double get directArtisanEarning => (price * artisanSharePercent) / 100;
  String get displayPrice => '₹${price.toStringAsFixed(0)}';
  String get displayOriginalPrice =>
      originalPrice != null ? '₹${originalPrice!.toStringAsFixed(0)}' : '';
}
