import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../widgets/price_card.dart';
import '../../widgets/story_card.dart';
import 'artisan_profile.dart';
import 'cart.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  final ProductProvider productProvider;
  final CartProvider cartProvider;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.productProvider,
    required this.cartProvider,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final artisan = widget.productProvider.getArtisanById(product.artisanId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          product.category,
          style: AppTypography.headlineSm.copyWith(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sharing artisan craft link...'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Saved to wishlist'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Display
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.1,
                    child: Image.network(
                      product.images[_selectedImageIndex % product.images.length],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surfaceContainer,
                        child: const Icon(Icons.image, size: 60, color: AppColors.outline),
                      ),
                    ),
                  ),

                  // Verified Craft Seal Badge
                  if (product.isVerifiedCraft)
                    Positioned(
                      top: AppDimensions.spaceMd,
                      left: AppDimensions.spaceMd,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.forestGreen,
                          borderRadius: AppDimensions.roundedFull,
                          boxShadow: const [AppColors.pressedShadow],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.verified_rounded, size: 14, color: AppColors.pureWhite),
                            SizedBox(width: 4),
                            Text(
                              'GI Authenticated Craft',
                              style: TextStyle(
                                color: AppColors.pureWhite,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              // Thumbnail row if multiple images
              if (product.images.length > 1) ...[
                const SizedBox(height: AppDimensions.spaceSm),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.margin),
                    itemCount: product.images.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedImageIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedImageIndex = index),
                        child: Container(
                          width: 60,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: AppDimensions.roundedDefault,
                            border: Border.all(
                              color: isSelected ? AppColors.terracotta : AppColors.surfaceContainerHigh,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: AppDimensions.roundedDefault,
                            child: Image.network(product.images[index], fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],

              // Product Info Block
              Padding(
                padding: AppDimensions.paddingPage,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      product.name,
                      style: AppTypography.headlineMd.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Rating and Origin
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 18, color: AppColors.warmSaffron),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.reviewsCount} reviews)',
                          style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• ${product.artisanLocation}',
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.terracotta,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),

                    // Pricing block
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.displayPrice,
                          style: AppTypography.headlineLg.copyWith(
                            color: AppColors.terracotta,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (product.originalPrice != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              product.displayOriginalPrice,
                              style: AppTypography.bodyLg.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.outline,
                              ),
                            ),
                          ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.tertiaryFixed.withValues(alpha: 0.5),
                            borderRadius: AppDimensions.roundedFull,
                          ),
                          child: Text(
                            'Fair-Price Verified',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.tertiary,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spaceLg),

                    // Meet the Maker Container
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.spaceMd),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: AppDimensions.roundedLg,
                        boxShadow: const [AppColors.cardShadow],
                        border: Border.all(color: AppColors.surfaceContainerHigh),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: AppColors.surfaceContainer,
                            backgroundImage: NetworkImage(product.artisanAvatar),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Handcrafted by',
                                  style: AppTypography.bodySm.copyWith(
                                    fontSize: 11,
                                    color: AppColors.outline,
                                  ),
                                ),
                                Text(
                                  product.artisanName,
                                  style: AppTypography.labelLg.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  product.artisanLocation,
                                  style: AppTypography.bodySm.copyWith(
                                    fontSize: 12,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (artisan != null)
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(80, 36),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppDimensions.roundedFull,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ArtisanProfileScreen(
                                      artisan: artisan,
                                      productProvider: widget.productProvider,
                                      cartProvider: widget.cartProvider,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('View Maker', style: TextStyle(fontSize: 12)),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceLg),

                    // Cultural Heritage & Audio Story Card
                    StoryCard(
                      title: 'The Heritage Story',
                      story: product.culturalStory,
                      artisanName: product.artisanName,
                      craftHeritage: 'Generational Knowledge',
                      durationSeconds: 155,
                    ),
                    const SizedBox(height: AppDimensions.spaceLg),

                    // Price Breakdown Card
                    PriceCard(
                      currentPrice: product.price,
                      fairPriceMin: product.fairPriceMin,
                      fairPriceMax: product.fairPriceMax,
                      laborHours: product.timeToCreateHours,
                      artisanSharePercent: product.artisanSharePercent,
                    ),
                    const SizedBox(height: AppDimensions.spaceLg),

                    // Craft Specifications
                    Text(
                      'Craft Specifications',
                      style: AppTypography.headlineSm.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: AppDimensions.spaceSm),
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.spaceMd),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: AppDimensions.roundedLg,
                        border: Border.all(color: AppColors.surfaceContainerHigh),
                      ),
                      child: Column(
                        children: [
                          _specRow('Creation Time', '${product.timeToCreateHours} hours of patient handcrafting'),
                          const Divider(),
                          _specRow('Dimensions', product.dimensions),
                          const Divider(),
                          _specRow('Weight', product.weight),
                          const Divider(),
                          _specRow(
                            'Raw Materials',
                            product.materials.join(', '),
                          ),
                          const Divider(),
                          _specRow(
                            'Sustainability',
                            product.isSustainable ? '100% Biodegradable & Natural Pigments' : 'Handmade Traditional',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 80), // Space for sticky bottom bar
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Sticky Bottom Action Bar (48px Touch Targets)
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.margin, vertical: 12),
        decoration: const BoxDecoration(
          color: AppColors.pureWhite,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(34, 34, 34, 0.1),
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    widget.cartProvider.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.terracotta,
                        content: Text('Added "${product.name}" to cart'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.terracotta, width: 1.5),
                    foregroundColor: AppColors.terracotta,
                  ),
                  child: const Text('Add to Cart'),
                ),
              ),
              const SizedBox(width: AppDimensions.spaceSm + 4),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    widget.cartProvider.addToCart(product);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CartScreen(
                          cartProvider: widget.cartProvider,
                        ),
                      ),
                    );
                  },
                  child: const Text('Buy Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodySm.copyWith(color: AppColors.outline)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTypography.labelSm.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
