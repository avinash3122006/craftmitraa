import 'package:flutter/material.dart';
import '../../models/artisan_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../widgets/product_card.dart';
import '../../widgets/story_card.dart';
import 'product_details.dart';

class ArtisanProfileScreen extends StatelessWidget {
  final ArtisanModel artisan;
  final ProductProvider productProvider;
  final CartProvider cartProvider;

  const ArtisanProfileScreen({
    super.key,
    required this.artisan,
    required this.productProvider,
    required this.cartProvider,
  });

  @override
  Widget build(BuildContext context) {
    final artisanProducts = productProvider.filteredProducts
        .where((p) => p.artisanId == artisan.id || p.artisanName.contains(artisan.name.split(' ').first))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Hero Cover and Avatar
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    artisan.coverImageUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                          AppColors.background,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Artisan Profile Details
          SliverToBoxAdapter(
            child: Padding(
              padding: AppDimensions.paddingPage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: AppColors.surfaceContainer,
                            backgroundImage: NetworkImage(artisan.avatarUrl),
                          ),
                          if (artisan.isVerified)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: AppColors.pureWhite,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.verified_rounded,
                                  size: 18,
                                  color: AppColors.forestGreen,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: AppDimensions.spaceMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              artisan.name,
                              style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              artisan.craftType,
                              style: AppTypography.bodySm.copyWith(
                                color: AppColors.terracotta,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 14, color: AppColors.outline),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    artisan.fullLocation,
                                    style: AppTypography.bodySm.copyWith(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spaceLg),

                  // Metrics Row
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.spaceMd),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: AppDimensions.roundedLg,
                      boxShadow: const [AppColors.cardShadow],
                      border: Border.all(color: AppColors.surfaceContainerHigh),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _metricItem('${artisan.yearsOfExperience} Years', 'Generational Legacy'),
                        Container(width: 1, height: 36, color: AppColors.surfaceContainerHighest),
                        _metricItem('${artisan.rating} ★', '${artisan.reviewCount} Reviews'),
                        Container(width: 1, height: 36, color: AppColors.surfaceContainerHighest),
                        _metricItem('${artisan.productsCount}', 'Master Works'),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceLg),

                  // Bio prose
                  Text(
                    'Artisan Biography',
                    style: AppTypography.headlineSm.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    artisan.bio,
                    style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface, height: 1.5),
                  ),
                  const SizedBox(height: AppDimensions.spaceLg),

                  // Awards & Recognitions
                  if (artisan.awards.isNotEmpty) ...[
                    Text(
                      'National & Cultural Honors',
                      style: AppTypography.headlineSm.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: artisan.awards.map((award) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryFixed.withOpacity(0.4),
                            borderRadius: AppDimensions.roundedFull,
                            border: Border.all(color: AppColors.warmSaffron.withOpacity(0.5)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.workspace_premium_rounded, size: 16, color: AppColors.secondary),
                              const SizedBox(width: 6),
                              Text(
                                award,
                                style: AppTypography.labelSm.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.onSecondaryFixed,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppDimensions.spaceLg),
                  ],

                  // Oral Tradition Audio Story
                  StoryCard(
                    title: artisan.audioStoryTitle,
                    story: 'Recorded by ${artisan.name} at the village studio. Listen to how ancient techniques have been passed through songs, poetry, and earth lore.',
                    artisanName: artisan.name,
                    craftHeritage: artisan.craftType,
                    durationSeconds: artisan.audioDurationSeconds,
                  ),
                  const SizedBox(height: AppDimensions.spaceLg),

                  // Catalog by this artisan
                  Text(
                    'Creations by ${artisan.name}',
                    style: AppTypography.headlineSm.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: AppDimensions.spaceSm),
                ],
              ),
            ),
          ),

          // Artisan Products Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.margin),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: AppDimensions.spaceSm + 2,
                mainAxisSpacing: AppDimensions.spaceSm + 2,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final p = artisanProducts.isNotEmpty ? artisanProducts[index % artisanProducts.length] : productProvider.filteredProducts.first;
                  return ProductCard(
                    product: p,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            product: p,
                            productProvider: productProvider,
                            cartProvider: cartProvider,
                          ),
                        ),
                      );
                    },
                    onAddToCart: () {
                      cartProvider.addToCart(p);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added "${p.name}" to cart')),
                      );
                    },
                  );
                },
                childCount: artisanProducts.isNotEmpty ? artisanProducts.length : 2,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppDimensions.spaceXl)),
        ],
      ),
    );
  }

  Widget _metricItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headlineSm.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.terracotta,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.bodySm.copyWith(fontSize: 11, color: AppColors.outline),
        ),
      ],
    );
  }
}
