import 'package:flutter/material.dart';
import '../../providers/ai_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import 'capture_product.dart';

class AddProductScreen extends StatelessWidget {
  final ProductProvider? productProvider;
  final AIProvider? aiProvider;

  const AddProductScreen({
    super.key,
    this.productProvider,
    this.aiProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Add New Craft'),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppDimensions.paddingPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How would you like to list your craft?',
                style: AppTypography.headlineSm.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'We recommend using AI Voice & Camera assistance to automatically generate stories and calculate fair rates.',
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // AI Method Card
              Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.cardShadow],
                  border: Border.all(color: AppColors.terracotta, width: 1.5),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: AppDimensions.roundedLg,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CaptureProductScreen(
                            productProvider: productProvider ?? ProductProvider(),
                            aiProvider: aiProvider ?? AIProvider(),
                          ),
                        ),
                      );
                    },
                    borderRadius: AppDimensions.roundedLg,
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.spaceMd + 2),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryFixed.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.auto_awesome, color: AppColors.terracotta, size: 28),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'AI Voice & Vision',
                                      style: AppTypography.headlineSm.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.forestGreen.withOpacity(0.12),
                                        borderRadius: AppDimensions.roundedFull,
                                      ),
                                      child: const Text(
                                        'Recommended',
                                        style: TextStyle(
                                          color: AppColors.forestGreen,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Speak in Hindi/regional language and snap 1 photo. Ready in 60s.',
                                  style: AppTypography.bodySm.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.terracotta),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMd),

              // Manual Entry Option
              Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.pressedShadow],
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: ListTile(
                  leading: const Icon(Icons.edit_note_rounded, color: AppColors.outline),
                  title: const Text('Manual Form Entry'),
                  subtitle: const Text('Fill out title, pricing, dimensions and materials by hand'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Manual form available. Tap AI Voice for faster listing.')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
