import 'package:flutter/material.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../widgets/product_card.dart';
import 'product_details.dart';

class SearchScreen extends StatefulWidget {
  final ProductProvider productProvider;
  final CartProvider cartProvider;

  const SearchScreen({
    super.key,
    required this.productProvider,
    required this.cartProvider,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _popularTags = [
    'Terracotta Plaque',
    'Molela Clay',
    'Chanderi Silk',
    'Mithila Art',
    'Dhokra Brass',
    'Sheesham Wood',
    'GI Tagged',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = widget.productProvider.filteredProducts;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          height: 44,
          margin: const EdgeInsets.only(right: AppDimensions.margin),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: AppDimensions.roundedLg,
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: TextField(
            controller: _controller,
            autofocus: true,
            onChanged: (val) {
              widget.productProvider.setSearchQuery(val);
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: 'Search craft, art, or artisan name...',
              prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.outline),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        _controller.clear();
                        widget.productProvider.setSearchQuery('');
                        setState(() {});
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_controller.text.isEmpty) ...[
              Padding(
                padding: AppDimensions.paddingPage,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular Heritage Searches',
                      style: AppTypography.headlineSm.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: AppDimensions.spaceSm),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _popularTags.map((tag) {
                        return ActionChip(
                          label: Text(tag),
                          backgroundColor: AppColors.pureWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppDimensions.roundedFull,
                            side: const BorderSide(color: AppColors.surfaceContainerHigh),
                          ),
                          labelStyle: AppTypography.labelSm.copyWith(fontSize: 12),
                          onPressed: () {
                            _controller.text = tag;
                            widget.productProvider.setSearchQuery(tag);
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.margin, vertical: 4),
              child: Text(
                '${results.length} results found',
                style: AppTypography.bodySm.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(AppDimensions.margin),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: AppDimensions.spaceSm + 2,
                  mainAxisSpacing: AppDimensions.spaceSm + 2,
                ),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final p = results[index];
                  return ProductCard(
                    product: p,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            product: p,
                            productProvider: widget.productProvider,
                            cartProvider: widget.cartProvider,
                          ),
                        ),
                      );
                    },
                    onAddToCart: () {
                      widget.cartProvider.addToCart(p);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added "${p.name}" to cart')),
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
