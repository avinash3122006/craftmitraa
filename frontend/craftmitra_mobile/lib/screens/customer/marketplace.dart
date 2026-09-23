import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../widgets/product_card.dart';
import 'product_details.dart';

class MarketplaceScreen extends StatefulWidget {
  final ProductProvider productProvider;
  final CartProvider cartProvider;

  const MarketplaceScreen({
    super.key,
    required this.productProvider,
    required this.cartProvider,
  });

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _onlyVerified = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = widget.productProvider.filteredProducts;
    if (_onlyVerified) {
      products = products.where((p) => p.isVerifiedCraft).toList();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Artisan Marketplace'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.margin),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.pressedShadow],
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    widget.productProvider.setSearchQuery(val);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Search craft, region (e.g. Molela, Chanderi)...',
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.outline),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: AppColors.outline),
                            onPressed: () {
                              _searchController.clear();
                              widget.productProvider.setSearchQuery('');
                              setState(() {});
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceSm),

            // Horizontal Category Pills
            SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.margin),
                itemCount: widget.productProvider.categories.length,
                itemBuilder: (context, index) {
                  final cat = widget.productProvider.categories[index];
                  final isSelected = widget.productProvider.selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: AppColors.terracotta,
                      backgroundColor: AppColors.pureWhite,
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.pureWhite : AppColors.onSurface,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppDimensions.roundedFull,
                        side: BorderSide(
                          color: isSelected ? AppColors.terracotta : AppColors.surfaceContainerHigh,
                        ),
                      ),
                      onSelected: (_) {
                        widget.productProvider.selectCategory(cat);
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 6),

            // Filter bar: count & GI Verified toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.margin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${products.length} Authentic Crafts found',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  FilterChip(
                    label: const Text('GI Tagged Only'),
                    selected: _onlyVerified,
                    selectedColor: AppColors.tertiaryFixed,
                    checkmarkColor: AppColors.tertiary,
                    labelStyle: AppTypography.labelSm.copyWith(
                      fontSize: 11,
                      color: _onlyVerified ? AppColors.tertiary : AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                    onSelected: (val) {
                      setState(() => _onlyVerified = val);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDimensions.roundedFull,
                      side: BorderSide(
                        color: _onlyVerified ? AppColors.forestGreen : AppColors.outlineVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),

            // Product Grid or Empty State
            Expanded(
              child: products.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: AppColors.outline,
                          ),
                          const SizedBox(height: AppDimensions.spaceMd),
                          Text(
                            'No handcrafted crafts matched',
                            style: AppTypography.headlineSm.copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Try resetting filters or searching another craft style',
                            style: AppTypography.bodySm,
                          ),
                          const SizedBox(height: AppDimensions.spaceMd),
                          OutlinedButton(
                            onPressed: () {
                              _searchController.clear();
                              widget.productProvider.setSearchQuery('');
                              widget.productProvider.selectCategory('All');
                              setState(() => _onlyVerified = false);
                            },
                            child: const Text('Reset All Filters'),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(AppDimensions.margin),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: AppDimensions.spaceSm + 2,
                        mainAxisSpacing: AppDimensions.spaceSm + 2,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(
                          product: product,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProductDetailsScreen(
                                  product: product,
                                  productProvider: widget.productProvider,
                                  cartProvider: widget.cartProvider,
                                ),
                              ),
                            );
                          },
                          onAddToCart: () {
                            widget.cartProvider.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.terracotta,
                                content: Text('Added "${product.name}" to cart'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
