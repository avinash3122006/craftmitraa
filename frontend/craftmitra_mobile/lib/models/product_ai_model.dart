class ProductAIModel {
  final String suggestedTitle;
  final String category;
  final String generatedDescription;
  final String culturalStory;
  final List<String> detectedMaterials;
  final double suggestedFairPriceMin;
  final double suggestedFairPriceMax;
  final double recommendedPrice;
  final int estimatedLaborHours;
  final List<String> suggestedTags;
  final double confidenceScore;
  final String voiceTranscript;
  final String sustainabilityRating;

  ProductAIModel({
    required this.suggestedTitle,
    required this.category,
    required this.generatedDescription,
    required this.culturalStory,
    required this.detectedMaterials,
    required this.suggestedFairPriceMin,
    required this.suggestedFairPriceMax,
    required this.recommendedPrice,
    required this.estimatedLaborHours,
    required this.suggestedTags,
    this.confidenceScore = 0.94,
    required this.voiceTranscript,
    this.sustainabilityRating = '100% Eco-friendly Natural Clay',
  });
}
