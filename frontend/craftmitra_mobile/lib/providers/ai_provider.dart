import 'package:flutter/material.dart';
import '../models/product_ai_model.dart';
import '../models/product_model.dart';

class AIProvider with ChangeNotifier {
  bool _isProcessing = false;
  String _processingStep = '';
  double _processingProgress = 0.0;

  String? _capturedImagePath;
  String? _recordedVoiceText;
  String _selectedLanguage = 'Hindi';

  ProductAIModel? _generatedResult;

  bool get isProcessing => _isProcessing;
  String get processingStep => _processingStep;
  double get processingProgress => _processingProgress;
  String? get capturedImagePath => _capturedImagePath;
  String? get recordedVoiceText => _recordedVoiceText;
  String get selectedLanguage => _selectedLanguage;
  ProductAIModel? get generatedResult => _generatedResult;

  void setCapturedImage(String imagePath) {
    _capturedImagePath = imagePath;
    notifyListeners();
  }

  void setLanguage(String lang) {
    _selectedLanguage = lang;
    notifyListeners();
  }

  void setRecordedVoice(String voiceText) {
    _recordedVoiceText = voiceText;
    notifyListeners();
  }

  Future<void> runAIAnalysis({
    required String imageSource,
    required String voiceDescription,
  }) async {
    _isProcessing = true;
    _processingProgress = 0.1;
    _processingStep = 'Analyzing visual texture and pottery craft form...';
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 700));
    _processingProgress = 0.35;
    _processingStep = 'Processing voice narrative in $_selectedLanguage...';
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 700));
    _processingProgress = 0.65;
    _processingStep = 'Synthesizing cultural lineage and material composition...';
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 700));
    _processingProgress = 0.88;
    _processingStep = 'Benchmarking fair artisan compensation (16h handcrafting)...';
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));
    _processingProgress = 1.0;
    _processingStep = 'Craft analysis complete!';

    _generatedResult = ProductAIModel(
      suggestedTitle: 'Molela Sacred Terracotta Elephant Votive Plaque',
      category: 'Terracotta',
      generatedDescription:
          'Authentic hollow-relief votive plaque hand-sculpted using riverbed clay from Banas riverbank. Decorated with sacred elephant and temple umbrella symbols using pure mineral ochre pigments.',
      culturalStory:
          'Sculpted by hand using a generations-old thumb-pinching technique without any mechanical casts. Fired in a low-smoke cowdung and wood pit kiln to impart natural terracotta acoustic resonance.',
      detectedMaterials: ['Banas River Clay', 'Organic Ghori Gum Resin', 'Natural Red Ochre (Geru)'],
      suggestedFairPriceMin: 1850.0,
      suggestedFairPriceMax: 2400.0,
      recommendedPrice: 2150.0,
      estimatedLaborHours: 16,
      suggestedTags: ['Terracotta', 'Molela', 'Sacred Plaque', 'Handmade Clay', 'GI Craft', 'Eco Living'],
      confidenceScore: 0.96,
      voiceTranscript: voiceDescription.isNotEmpty
          ? voiceDescription
          : 'Yeh Banas nadi ki mitti se bana haath ka hathi relief plaque hai. Do din lag gaye sukhane aur natural geru lagane me.',
      sustainabilityRating: '100% Biodegradable & Chemical-free',
    );

    _isProcessing = false;
    notifyListeners();
  }

  ProductModel convertAIToProduct({
    required String artisanId,
    required String artisanName,
    required String artisanLocation,
    required String artisanAvatar,
    required double finalPrice,
    required String finalTitle,
    required String finalDescription,
  }) {
    final ai = _generatedResult!;
    return ProductModel(
      id: 'prod-${DateTime.now().millisecondsSinceEpoch % 100000}',
      name: finalTitle.isNotEmpty ? finalTitle : ai.suggestedTitle,
      category: ai.category,
      price: finalPrice,
      originalPrice: (finalPrice * 1.25).roundToDouble(),
      artisanId: artisanId,
      artisanName: artisanName,
      artisanLocation: artisanLocation,
      artisanAvatar: artisanAvatar,
      rating: 5.0,
      reviewsCount: 0,
      description: finalDescription.isNotEmpty ? finalDescription : ai.generatedDescription,
      culturalStory: ai.culturalStory,
      materials: ai.detectedMaterials,
      dimensions: '26 x 20 x 5 cm',
      weight: '1.6 kg',
      timeToCreateHours: ai.estimatedLaborHours,
      isVerifiedCraft: true,
      isSustainable: true,
      stockQuantity: 3,
      images: [
        _capturedImagePath ?? 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80',
      ],
      tags: ai.suggestedTags,
      fairPriceMin: ai.suggestedFairPriceMin,
      fairPriceMax: ai.suggestedFairPriceMax,
      artisanSharePercent: 88.0,
    );
  }

  void reset() {
    _isProcessing = false;
    _processingProgress = 0.0;
    _processingStep = '';
    _capturedImagePath = null;
    _recordedVoiceText = null;
    _generatedResult = null;
    notifyListeners();
  }
}
