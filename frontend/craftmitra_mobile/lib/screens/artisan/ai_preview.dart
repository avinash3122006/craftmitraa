import 'package:flutter/material.dart';
import '../../providers/ai_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';

class AIPreviewScreen extends StatefulWidget {
  final ProductProvider productProvider;
  final AIProvider aiProvider;

  const AIPreviewScreen({
    super.key,
    required this.productProvider,
    required this.aiProvider,
  });

  @override
  State<AIPreviewScreen> createState() => _AIPreviewScreenState();
}

class _AIPreviewScreenState extends State<AIPreviewScreen> {
  late TextEditingController _titleController;
  late TextEditingController _storyController;
  late double _selectedPrice;

  @override
  void initState() {
    super.initState();
    final ai = widget.aiProvider.generatedResult;
    _titleController = TextEditingController(text: ai?.suggestedTitle ?? 'Molela Sacred Elephant Plaque');
    _storyController = TextEditingController(text: ai?.culturalStory ?? 'Handmade using Banas river clay...');
    _selectedPrice = ai?.recommendedPrice ?? 2150.0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ai = widget.aiProvider.generatedResult;
    if (ai == null) {
      return const Scaffold(body: Center(child: Text('No AI analysis generated')));
    }

    final double artisanEarning = (_selectedPrice * 0.88);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Review AI Craft Listing'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.paddingPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AI Confidence Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.forestGreen.withOpacity(0.12),
                  borderRadius: AppDimensions.roundedMd,
                  border: Border.all(color: AppColors.forestGreen.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: AppColors.forestGreen, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'AI synthesized listing from your voice & photo with 96% confidence.',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.forestGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // Title Field
              Text(
                'AI Generated Craft Title',
                style: AppTypography.headlineSm.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.pressedShadow],
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: TextField(
                  controller: _titleController,
                  style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(AppDimensions.spaceMd),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // Fair Price Recommendation Slider Card
              Container(
                padding: const EdgeInsets.all(AppDimensions.spaceMd),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.cardShadow],
                  border: Border.all(color: AppColors.terracotta.withOpacity(0.3), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.balance_rounded, color: AppColors.terracotta, size: 20),
                            const SizedBox(width: 6),
                            Text(
                              'AI Fair-Price Recommendation',
                              style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.tertiaryFixed.withOpacity(0.4),
                            borderRadius: AppDimensions.roundedFull,
                          ),
                          child: Text(
                            '16h Labor Evaluated',
                            style: AppTypography.labelSm.copyWith(
                              fontSize: 10,
                              color: AppColors.tertiary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Text(
                      'Based on raw materials, hand-modeling hours & live national demand:',
                      style: AppTypography.bodySm.copyWith(color: AppColors.outline, fontSize: 12),
                    ),
                    const SizedBox(height: 10),

                    // Price and Slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Selling Price:',
                          style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '₹${_selectedPrice.toStringAsFixed(0)}',
                          style: AppTypography.headlineSm.copyWith(
                            color: AppColors.terracotta,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),

                    Slider(
                      value: _selectedPrice,
                      min: ai.suggestedFairPriceMin,
                      max: ai.suggestedFairPriceMax * 1.2,
                      divisions: 30,
                      activeColor: AppColors.terracotta,
                      inactiveColor: AppColors.surfaceContainerHigh,
                      onChanged: (val) {
                        setState(() => _selectedPrice = val);
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Min: ₹${ai.suggestedFairPriceMin.toStringAsFixed(0)}', style: AppTypography.bodySm.copyWith(fontSize: 11)),
                        Text('Max: ₹${ai.suggestedFairPriceMax.toStringAsFixed(0)}', style: AppTypography.bodySm.copyWith(fontSize: 11)),
                      ],
                    ),
                    const Divider(height: 20),

                    // Direct bank deposit calculation
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_rounded, color: AppColors.forestGreen, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'You receive ₹${artisanEarning.toStringAsFixed(0)} (88%) directly in your bank account',
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.forestGreen,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // Generated Cultural Story
              Text(
                'AI Composed Cultural Story',
                style: AppTypography.headlineSm.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.pressedShadow],
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: TextField(
                  controller: _storyController,
                  maxLines: 4,
                  style: AppTypography.bodyMd,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(AppDimensions.spaceMd),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // Detected Materials & Tags
              Text(
                'Detected Natural Materials & Tags',
                style: AppTypography.headlineSm.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...ai.detectedMaterials.map((m) => Chip(
                        label: Text(m),
                        backgroundColor: AppColors.surfaceContainerLow,
                        avatar: const Icon(Icons.eco_rounded, size: 14, color: AppColors.forestGreen),
                      )),
                  ...ai.suggestedTags.map((t) => Chip(
                        label: Text(t),
                        backgroundColor: AppColors.surfaceContainerLow,
                      )),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceXl),

              // 1-Click Publish Button (Min 48px touch target)
              ElevatedButton(
                onPressed: () {
                  final newProduct = widget.aiProvider.convertAIToProduct(
                    artisanId: 'art-001',
                    artisanName: 'Pandit Ramkishan Prajapati',
                    artisanLocation: 'Molela, Rajasthan',
                    artisanAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
                    finalPrice: _selectedPrice,
                    finalTitle: _titleController.text,
                    finalDescription: _storyController.text,
                  );

                  widget.productProvider.addProduct(newProduct);
                  widget.aiProvider.reset();

                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: AppDimensions.roundedLg),
                      title: const Row(
                        children: [
                          Icon(Icons.check_circle_rounded, color: AppColors.forestGreen),
                          SizedBox(width: 8),
                          Text('Craft Published!'),
                        ],
                      ),
                      content: Text(
                        'Your craft "${newProduct.name}" is now live on the nationwide CraftMitra marketplace at ₹${newProduct.displayPrice}.',
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          child: const Text('Back to Studio'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.publish_rounded, size: 20),
                    SizedBox(width: 8),
                    Text('Publish Craft to Marketplace'),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
            ],
          ),
        ),
      ),
    );
  }
}
