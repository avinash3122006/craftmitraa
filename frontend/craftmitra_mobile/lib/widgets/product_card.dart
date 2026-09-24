import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../theme/colors.dart';
import '../theme/dimensions.dart';
import '../theme/typography.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: AppDimensions.roundedLg,
        boxShadow: const [AppColors.cardShadow],
        border: Border.all(color: AppColors.surfaceContainerHigh, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppDimensions.roundedLg,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppDimensions.roundedLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Product Image with badges
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppDimensions.radiusLg),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.15,
                      child: Image.network(
                        product.images.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.surfaceContainer,
                            child: const Center(
                              child: Icon(
                                Icons.image_outlined,
                                color: AppColors.outline,
                                size: 36,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Category pill badge (top left)
                  Positioned(
                    top: AppDimensions.spaceSm,
                    left: AppDimensions.spaceSm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.warmCream.withValues(alpha: 0.95),
                        borderRadius: AppDimensions.roundedFull,
                        boxShadow: const [AppColors.pressedShadow],
                      ),
                      child: Text(
                        product.category,
                        style: AppTypography.labelSm.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ),
                  ),

                  // Verified Craft badge (top right)
                  if (product.isVerifiedCraft)
                    Positioned(
                      top: AppDimensions.spaceSm,
                      right: AppDimensions.spaceSm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.forestGreen,
                          borderRadius: AppDimensions.roundedFull,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.verified_rounded,
                              size: 12,
                              color: AppColors.pureWhite,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'Verified',
                              style: AppTypography.labelSm.copyWith(
                                color: AppColors.pureWhite,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              // Card Content
              Padding(
                padding: const EdgeInsets.all(AppDimensions.spaceSm + 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Artisan signature snippet
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 9,
                          backgroundColor: AppColors.surfaceContainer,
                          backgroundImage: NetworkImage(product.artisanAvatar),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            product.artisanName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.bodySm.copyWith(
                              fontSize: 11,
                              color: AppColors.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spaceXs),

                    // Product Title
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.headlineSm.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Rating and village location
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 15,
                          color: AppColors.warmSaffron,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: AppTypography.labelSm.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '• ${product.artisanLocation}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.bodySm.copyWith(
                              fontSize: 11,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Price and Add Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.displayPrice,
                              style: AppTypography.headlineSm.copyWith(
                                color: AppColors.terracotta,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (product.originalPrice != null)
                              Text(
                                product.displayOriginalPrice,
                                style: AppTypography.bodySm.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 11,
                                  color: AppColors.outline,
                                ),
                              ),
                          ],
                        ),

                        // Tactile Add to Cart CTA (min 48px touch target with padding)
                        Material(
                          color: AppColors.primaryContainer,
                          borderRadius: AppDimensions.roundedDefault,
                          child: InkWell(
                            onTap: onAddToCart,
                            borderRadius: AppDimensions.roundedDefault,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 15,
                                    color: AppColors.pureWhite,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Add',
                                    style: TextStyle(
                                      color: AppColors.pureWhite,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
