import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/artisan_model.dart';

class ProductProvider with ChangeNotifier {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> categories = [
    'All',
    'Terracotta',
    'Handloom',
    'Madhubani Art',
    'Brass & Metal',
    'Wood Carving',
    'Eco & Fiber',
  ];

  final List<ArtisanModel> _artisans = [
    ArtisanModel(
      id: 'art-001',
      name: 'Pandit Ramkishan Prajapati',
      craftType: 'Molela Terracotta Art',
      village: 'Molela',
      state: 'Rajasthan',
      bio: '4th generation terracotta sculptor specializing in sun-baked votive tablets using indigenous Banas river clay and organic stone dyes.',
      yearsOfExperience: 34,
      rating: 4.9,
      reviewCount: 284,
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
      coverImageUrl: 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80',
      awards: ['National Craft Master 2018', 'Shilp Guru Nominee'],
      audioStoryTitle: 'Echoes of Molela River Clay',
      audioDurationSeconds: 165,
      productsCount: 14,
    ),
    ArtisanModel(
      id: 'art-002',
      name: 'Shanti Devi Bunker',
      craftType: 'Chanderi Zari Weaving',
      village: 'Pranpur',
      state: 'Madhya Pradesh',
      bio: 'Master weaver preserving 700-year-old pit-loom silk weaving techniques taught by her grandmother. Empowers 28 rural women weavers.',
      yearsOfExperience: 26,
      rating: 5.0,
      reviewCount: 312,
      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
      coverImageUrl: 'https://images.unsplash.com/photo-1610030469983-98e550d6193c?auto=format&fit=crop&w=800&q=80',
      awards: ['Sant Kabir State Award', 'Craft Heritage Fellow'],
      audioStoryTitle: 'The Rhythm of the Pit Loom',
      audioDurationSeconds: 180,
      productsCount: 22,
    ),
    ArtisanModel(
      id: 'art-003',
      name: 'Geeta Jha',
      craftType: 'Mithila & Madhubani Art',
      village: 'Ranti',
      state: 'Bihar',
      bio: 'Creates natural pigment Mithila paintings depicting nature, rituals, and folklore using bamboo twigs and nib-pens on handmade cotton paper.',
      yearsOfExperience: 19,
      rating: 4.8,
      reviewCount: 198,
      avatarUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80',
      coverImageUrl: 'https://images.unsplash.com/photo-1582560475093-ba66accbc424?auto=format&fit=crop&w=800&q=80',
      awards: ['State Handicraft Excellence 2021'],
      audioStoryTitle: 'Living Colors of Mithila Soil',
      audioDurationSeconds: 140,
      productsCount: 16,
    ),
    ArtisanModel(
      id: 'art-004',
      name: 'Budhram Baghel',
      craftType: 'Bastar Dhokra Lost-Wax Casting',
      village: 'Kondagaon',
      state: 'Chhattisgarh',
      bio: 'Practices ancient 4,000-year-old Harappan lost-wax bell metal casting using beeswax, riverbed clay, and recycled brass scraps.',
      yearsOfExperience: 31,
      rating: 4.9,
      reviewCount: 174,
      avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80',
      coverImageUrl: 'https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&w=800&q=80',
      awards: ['Tribal Artisan Honor 2019'],
      audioStoryTitle: 'Fire and Beeswax in the Bastar Woods',
      audioDurationSeconds: 155,
      productsCount: 11,
    ),
  ];

  late List<ProductModel> _products;

  ProductProvider() {
    _products = [
      ProductModel(
        id: 'prod-001',
        name: 'Molela Sun God Terracotta Wall Plaque',
        category: 'Terracotta',
        price: 2450.0,
        originalPrice: 3200.0,
        artisanId: 'art-001',
        artisanName: 'Pandit Ramkishan Prajapati',
        artisanLocation: 'Molela, Rajasthan',
        artisanAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
        rating: 4.9,
        reviewsCount: 86,
        description: 'Hand-sculpted ritual terracotta wall tile depicting Surya Dev, crafted from fertile Banas river clay and dried under desert sun.',
        culturalStory: 'Molela hollow votive plaques have been crafted for over 300 years by the Kumhar community for tribal shrines in southern Rajasthan. Every line is hand-pinched with thumb and wooden knife without molds.',
        materials: ['Riverbed Clay', 'Natural Acacia Resin', 'Ochre Red Pigment'],
        dimensions: '30 x 22 x 6 cm',
        weight: '2.1 kg',
        timeToCreateHours: 28,
        isVerifiedCraft: true,
        isSustainable: true,
        stockQuantity: 4,
        images: [
          'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?auto=format&fit=crop&w=800&q=80',
        ],
        tags: ['Terracotta', 'Handcrafted', 'Molela', 'Wall Decor', 'GI Tagged'],
        fairPriceMin: 2200.0,
        fairPriceMax: 2800.0,
        artisanSharePercent: 86.0,
      ),
      ProductModel(
        id: 'prod-002',
        name: 'Pure Chanderi Silk Zari Saree in Ochre',
        category: 'Handloom',
        price: 7800.0,
        originalPrice: 9500.0,
        artisanId: 'art-002',
        artisanName: 'Shanti Devi Bunker',
        artisanLocation: 'Pranpur, Madhya Pradesh',
        artisanAvatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
        rating: 5.0,
        reviewsCount: 142,
        description: 'Feather-light Chanderi silk saree with hand-woven tested zari bootis and traditional ashrafi borders woven on wooden pit-looms.',
        culturalStory: 'Chanderi weaving flourished under royal Scindia patronage. This saree took Shanti Devi and her daughter 18 days of rhythmic loom work, passing silk threads through comb teeth 1,200 times per meter.',
        materials: ['Pure Mulberry Silk', 'Fine Cotton Warp', 'Tested Gold Zari'],
        dimensions: '5.5 m + 80 cm blouse',
        weight: '430 grams',
        timeToCreateHours: 64,
        isVerifiedCraft: true,
        isSustainable: true,
        stockQuantity: 2,
        images: [
          'https://images.unsplash.com/photo-1610030469983-98e550d6193c?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?auto=format&fit=crop&w=800&q=80',
        ],
        tags: ['Handloom', 'Silk', 'Chanderi', 'Traditional Wear', 'Pit-Loom'],
        fairPriceMin: 7200.0,
        fairPriceMax: 8500.0,
        artisanSharePercent: 88.0,
      ),
      ProductModel(
        id: 'prod-003',
        name: 'Madhubani Tree of Life Folk Painting',
        category: 'Madhubani Art',
        price: 3600.0,
        originalPrice: 4500.0,
        artisanId: 'art-003',
        artisanName: 'Geeta Jha',
        artisanLocation: 'Ranti, Bihar',
        artisanAvatar: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80',
        rating: 4.8,
        reviewsCount: 64,
        description: 'Original hand-drawn Mithila artwork symbolizing fertility and eternity, made with bamboo reeds and soot ink on cowdung-treated paper.',
        culturalStory: 'In Mithila culture, women draw the sacred Kalpavriksha tree on home mud walls during weddings. Geeta prepares pigments from turmeric, bilva leaves, and flame-of-forest blossoms.',
        materials: ['Handmade Khadi Paper', 'Natural Vegetable Inks', 'Soot Dye'],
        dimensions: '42 x 30 cm',
        weight: '150 grams',
        timeToCreateHours: 22,
        isVerifiedCraft: true,
        isSustainable: true,
        stockQuantity: 6,
        images: [
          'https://images.unsplash.com/photo-1582560475093-ba66accbc424?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?auto=format&fit=crop&w=800&q=80',
        ],
        tags: ['Mithila Art', 'Natural Pigments', 'Madhubani', 'Wall Art'],
        fairPriceMin: 3200.0,
        fairPriceMax: 4000.0,
        artisanSharePercent: 85.0,
      ),
      ProductModel(
        id: 'prod-004',
        name: 'Bastar Dhokra Lost-Wax Horn Musician',
        category: 'Brass & Metal',
        price: 2900.0,
        originalPrice: 3800.0,
        artisanId: 'art-004',
        artisanName: 'Budhram Baghel',
        artisanLocation: 'Kondagaon, Chhattisgarh',
        artisanAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80',
        rating: 4.9,
        reviewsCount: 52,
        description: 'Single-cast brass figurine created using the rare ancient hollow lost-wax casting technique passed down by Bastar tribal elders.',
        culturalStory: 'Because the clay core mold is shattered to release the molten metal, no two Dhokra figures in the world can ever be identical. This musician captures traditional forest harvest festivals.',
        materials: ['Recycled Brass', 'Natural Beeswax', 'Termite Hill Mud'],
        dimensions: '22 x 10 x 8 cm',
        weight: '1.4 kg',
        timeToCreateHours: 36,
        isVerifiedCraft: true,
        isSustainable: true,
        stockQuantity: 3,
        images: [
          'https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&w=800&q=80',
        ],
        tags: ['Dhokra', 'Tribal Art', 'Lost Wax', 'Brass Figurine', 'GI Certified'],
        fairPriceMin: 2600.0,
        fairPriceMax: 3400.0,
        artisanSharePercent: 87.0,
      ),
      ProductModel(
        id: 'prod-005',
        name: 'Saharanpur Hand-carved Sheesham Jali Box',
        category: 'Wood Carving',
        price: 1850.0,
        originalPrice: 2400.0,
        artisanId: 'art-001',
        artisanName: 'Mohd. Iqbal Ansari',
        artisanLocation: 'Saharanpur, Uttar Pradesh',
        artisanAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=400&q=80',
        rating: 4.7,
        reviewsCount: 78,
        description: 'Intricately pierced floral fretwork box carved from reclaimed aged Indian Rosewood (Sheesham) with brass inlay accents.',
        culturalStory: 'Saharanpur woodcraft traces its origins to Mughal architecture. Each perforation is individually chiseled with hand-forged gouges without machine laser stamping.',
        materials: ['Aged Sheesham Wood', 'Brass Leaf Inlay', 'Natural Beeswax Polish'],
        dimensions: '20 x 14 x 9 cm',
        weight: '750 grams',
        timeToCreateHours: 16,
        isVerifiedCraft: true,
        isSustainable: true,
        stockQuantity: 7,
        images: [
          'https://images.unsplash.com/photo-1532372576444-dda954194ad0?auto=format&fit=crop&w=800&q=80',
        ],
        tags: ['Woodwork', 'Jali Carving', 'Keepsake Box', 'Eco-friendly'],
        fairPriceMin: 1650.0,
        fairPriceMax: 2100.0,
        artisanSharePercent: 84.0,
      ),
      ProductModel(
        id: 'prod-006',
        name: 'Kendrapara Golden Grass Handwoven Basket',
        category: 'Eco & Fiber',
        price: 1250.0,
        originalPrice: 1600.0,
        artisanId: 'art-002',
        artisanName: 'Meenakshi Pradhan',
        artisanLocation: 'Kendrapara, Odisha',
        artisanAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
        rating: 4.8,
        reviewsCount: 39,
        description: 'Biodegradable natural golden grass (Kaincha) storage basket woven by coastal rural women with geometric dyed accents.',
        culturalStory: 'Kaincha grass grows wild in riparian wetlands. Artisans split the stems using teeth and fingers, then weave sturdy storage vessels that last over two decades.',
        materials: ['Wild Kaincha Grass', 'Organic Beetroot Dye'],
        dimensions: '28 x 28 x 20 cm',
        weight: '480 grams',
        timeToCreateHours: 12,
        isVerifiedCraft: true,
        isSustainable: true,
        stockQuantity: 9,
        images: [
          'https://images.unsplash.com/photo-1584992236310-6edddc08acff?auto=format&fit=crop&w=800&q=80',
        ],
        tags: ['Kaincha Grass', 'Zero Waste', 'Eco Friendly', 'Storage Basket'],
        fairPriceMin: 1100.0,
        fairPriceMax: 1450.0,
        artisanSharePercent: 90.0,
      ),
    ];
  }

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  List<ArtisanModel> get artisans => _artisans;

  List<ProductModel> get filteredProducts {
    return _products.where((item) {
      final matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.artisanName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.tags.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  ProductModel? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return _products.isNotEmpty ? _products.first : null;
    }
  }

  ArtisanModel? getArtisanById(String id) {
    try {
      return _artisans.firstWhere((a) => a.id == id);
    } catch (_) {
      return _artisans.isNotEmpty ? _artisans.first : null;
    }
  }

  void addProduct(ProductModel newProduct) {
    _products.insert(0, newProduct);
    notifyListeners();
  }
}
