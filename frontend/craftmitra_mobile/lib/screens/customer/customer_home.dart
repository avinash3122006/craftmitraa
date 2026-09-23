import 'package:flutter/material.dart';
import '../../models/artisan_model.dart';
import '../../models/product_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../widgets/artisan_card.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/product_card.dart';
import '../artisan/artisan_home.dart';
import 'artisan_profile.dart';
import 'cart.dart';
import 'marketplace.dart';
import 'order_tracking.dart';
import 'product_details.dart';
import 'search_screen.dart';
import '../common/notifications.dart';
import '../common/settings.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _currentTabIndex = 0;

  // Local instance for self-contained execution if global provider is not mounted
  late ProductProvider _productProvider;
  late CartProvider _cartProvider;
  late OrderProvider _orderProvider;
  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _productProvider = ProductProvider();
    _cartProvider = CartProvider();
    _orderProvider = OrderProvider();
    _authProvider = AuthProvider();

    _productProvider.addListener(_onStateChange);
    _cartProvider.addListener(_onStateChange);
    _orderProvider.addListener(_onStateChange);
    _authProvider.addListener(_onStateChange);
  }

  void _onStateChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _productProvider.removeListener(_onStateChange);
    _cartProvider.removeListener(_onStateChange);
    _orderProvider.removeListener(_onStateChange);
    _authProvider.removeListener(_onStateChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          _buildDiscoverView(),
          MarketplaceScreen(
            productProvider: _productProvider,
            cartProvider: _cartProvider,
          ),
          CartScreen(
            cartProvider: _cartProvider,
            orderProvider: _orderProvider,
          ),
          OrderTrackingScreen(
            orderProvider: _orderProvider,
          ),
          SettingsScreen(
            authProvider: _authProvider,
          ),
        ],
      ),
      bottomNavigationBar: CraftMitraBottomNav(
        currentIndex: _currentTabIndex,
        isArtisanMode: false,
        cartItemCount: _cartProvider.itemCount,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildDiscoverView() {
    final products = _productProvider.filteredProducts;
    final artisans = _productProvider.artisans;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Top Bar with Location, Persona Switcher, Cart
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.margin,
                vertical: AppDimensions.spaceSm,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Location selector
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: AppColors.terracotta,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Deliver to',
                                  style: AppTypography.bodySm.copyWith(
                                    fontSize: 11,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Bengaluru, Karnataka - 560034',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelMd.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Quick Persona Switcher Pill (Artisan Mode toggle)
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const ArtisanHomeScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.tertiaryFixed.withOpacity(0.5),
                            borderRadius: AppDimensions.roundedFull,
                            border: Border.all(color: AppColors.forestGreen.withOpacity(0.4)),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.swap_horiz_rounded,
                                size: 16,
                                color: AppColors.tertiary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Artisan Studio',
                                style: AppTypography.labelSm.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Notifications icon
                      IconButton(
                        icon: const Icon(Icons.notifications_none_rounded, color: AppColors.onSurface),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const NotificationsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spaceSm),

                  // Search Bar
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SearchScreen(
                            productProvider: _productProvider,
                            cartProvider: _cartProvider,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: AppDimensions.roundedLg,
                        boxShadow: const [AppColors.pressedShadow],
                        border: Border.all(color: AppColors.surfaceContainerHigh),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded, color: AppColors.outline),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Search handmade terracotta, handloom, art...',
                              style: AppTypography.bodyMd.copyWith(
                                color: AppColors.onSurfaceVariant.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const Icon(Icons.mic_none_rounded, color: AppColors.terracotta, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Cultural Heritage Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.margin,
                vertical: AppDimensions.spaceSm,
              ),
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.spaceMd + 2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.cardShadow],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.pureWhite.withOpacity(0.2),
                              borderRadius: AppDimensions.roundedFull,
                            ),
                            child: Text(
                              '100% DIRECT FAIR TRADE',
                              style: AppTypography.labelSm.copyWith(
                                color: AppColors.pureWhite,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Connecting Rural Hands to Modern Homes',
                            style: AppTypography.headlineSm.copyWith(
                              color: AppColors.pureWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Every purchase credits 85%+ directly into the rural artisan\'s bank.',
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.pureWhite.withOpacity(0.9),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.handshake_outlined,
                          size: 32,
                          color: AppColors.pureWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Categories Horizontal Filter Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.margin),
                itemCount: _productProvider.categories.length,
                itemBuilder: (context, index) {
                  final cat = _productProvider.categories[index];
                  final isSelected = _productProvider.selectedCategory == cat;
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
                          color: isSelected
                              ? AppColors.terracotta
                              : AppColors.surfaceContainerHigh,
                        ),
                      ),
                      onSelected: (_) {
                        _productProvider.selectCategory(cat);
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // Section 1 Header: Master Artisans Behind the Crafts
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.margin,
                AppDimensions.spaceLg,
                AppDimensions.margin,
                AppDimensions.spaceSm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Master Artisans of India',
                        style: AppTypography.headlineSm.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Keepers of ancient generational crafts',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      _currentTabIndex = 1;
                      setState(() {});
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),
          ),

          // Master Artisans Horizontal Scroll
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.margin),
                itemCount: artisans.length,
                itemBuilder: (context, index) {
                  final artisan = artisans[index];
                  return ArtisanCard(
                    artisan: artisan,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ArtisanProfileScreen(
                            artisan: artisan,
                            productProvider: _productProvider,
                            cartProvider: _cartProvider,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // Section 2 Header: Handcrafted GI-Certified Treasures
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.margin,
                AppDimensions.spaceLg,
                AppDimensions.margin,
                AppDimensions.spaceSm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Authentic Handcrafted Crafts',
                        style: AppTypography.headlineSm.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Direct from village kilns & handlooms',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.forestGreen.withOpacity(0.12),
                      borderRadius: AppDimensions.roundedFull,
                    ),
                    child: Text(
                      'GI Verified',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.forestGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2-Column Product Grid
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
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            product: product,
                            productProvider: _productProvider,
                            cartProvider: _cartProvider,
                          ),
                        ),
                      );
                    },
                    onAddToCart: () {
                      _cartProvider.addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.terracotta,
                          content: Text('Added "${product.name}" to cart'),
                          action: SnackBarAction(
                            label: 'View Cart',
                            textColor: AppColors.pureWhite,
                            onPressed: () {
                              setState(() => _currentTabIndex = 2);
                            },
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                },
                childCount: products.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppDimensions.spaceXl),
          ),
        ],
      ),
    );
  }
}
