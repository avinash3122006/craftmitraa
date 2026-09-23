import 'package:flutter/material.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';

class MyProductsScreen extends StatelessWidget {
  final ProductProvider productProvider;

  const MyProductsScreen({
    super.key,
    required this.productProvider,
  });

  @override
  Widget build(BuildContext context) {
    final products = productProvider.filteredProducts;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Studio Crafts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: AppDimensions.paddingPage,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${products.length} Active Listings',
                  style: AppTypography.headlineSm.copyWith(fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.forestGreen.withOpacity(0.12),
                    borderRadius: AppDimensions.roundedFull,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 14, color: AppColors.forestGreen),
                      SizedBox(width: 4),
                      Text(
                        'All GI Verified',
                        style: TextStyle(
                          color: AppColors.forestGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceMd),

            ...products.map((p) {
              return Container(
                margin: const EdgeInsets.only(bottom: AppDimensions.spaceMd),
                padding: const EdgeInsets.all(AppDimensions.spaceSm + 4),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.cardShadow],
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: AppDimensions.roundedDefault,
                      child: SizedBox(
                        width: 76,
                        height: 76,
                        child: Image.network(p.images.first, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spaceSm + 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${p.category} • In Stock (${p.stockQuantity})',
                            style: AppTypography.bodySm.copyWith(
                              fontSize: 11,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text(
                                p.displayPrice,
                                style: AppTypography.headlineSm.copyWith(
                                  color: AppColors.terracotta,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Your Payout: ₹${p.directArtisanEarning.toStringAsFixed(0)}',
                                style: AppTypography.bodySm.copyWith(
                                  fontSize: 11,
                                  color: AppColors.forestGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: AppColors.outline),
                      onSelected: (val) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Action "$val" performed')),
                        );
                      },
                      itemBuilder: (ctx) => [
                        const PopupMenuItem(value: 'Edit Craft', child: Text('Edit Craft Details')),
                        const PopupMenuItem(value: 'Update Stock', child: Text('Update Stock')),
                        const PopupMenuItem(value: 'Generate AI Story', child: Text('Regenerate AI Story')),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
