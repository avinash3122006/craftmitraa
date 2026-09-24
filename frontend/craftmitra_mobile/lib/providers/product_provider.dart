import 'package:flutter/material.dart';

import '../models/artisan_model.dart';
import '../models/product_model.dart';
import '../services/product_api.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    _products = <ProductModel>[];
    _artisans = <ArtisanModel>[];
    loadProducts();
  }

  final ProductApi _productApi = ProductApi();
  final List<String> categories = [
    'All',
    'Terracotta',
    'Handloom',
    'Madhubani Art',
    'Brass & Metal',
    'Wood Carving',
    'Eco & Fiber',
  ];

  String _selectedCategory = 'All';
  String _searchQuery = '';
  List<ArtisanModel> _artisans = <ArtisanModel>[];
  List<ProductModel> _products = <ProductModel>[];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  List<ArtisanModel> get artisans => _artisans;
  List<ProductModel> get products => _products;

  Future<void> loadProducts({String? token}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final artisans = await _productApi.getArtisans(token: token);
      final products = await _productApi.getProducts(token: token);

      _artisans = artisans;
      _products = products;
    } catch (_) {
      _artisans = <ArtisanModel>[];
      _products = <ProductModel>[];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<ProductModel> get filteredProducts {
    return _products.where((item) {
      final matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.artisanName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.tags.any((tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()));
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
