import 'package:flutter/material.dart';
import '../../providers/ai_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../widgets/bottom_nav.dart';
import '../customer/customer_home.dart';
import 'artisan_orders.dart';
import 'artisan_profile.dart';
import 'capture_product.dart';
import 'my_products.dart';

class ArtisanHomeScreen extends StatefulWidget {
  const ArtisanHomeScreen({super.key});

  @override
  State<ArtisanHomeScreen> createState() => _ArtisanHomeScreenState();
}

class _ArtisanHomeScreenState extends State<ArtisanHomeScreen> {
  int _currentTabIndex = 0;
  late ProductProvider _productProvider;
  late AIProvider _aiProvider;

  @override
  void initState() {
    super.initState();
    _productProvider = ProductProvider();
    _aiProvider = AIProvider();

    _productProvider.addListener(_onStateChange);
    _aiProvider.addListener(_onStateChange);
  }

  void _onStateChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _productProvider.removeListener(_onStateChange);
    _aiProvider.removeListener(_onStateChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          _buildStudioDashboard(),
          MyProductsScreen(productProvider: _productProvider),
          CaptureProductScreen(
            productProvider: _productProvider,
            aiProvider: _aiProvider,
          ),
          const ArtisanOrdersScreen(),
          const ArtisanProfileManagementScreen(),
        ],
      ),
      bottomNavigationBar: CraftMitraBottomNav(
        currentIndex: _currentTabIndex,
        isArtisanMode: true,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildStudioDashboard() {
    return SafeArea(
      child: ListView(
        padding: AppDimensions.paddingPage,
        children: [
          // Artisan Header & Persona Switcher
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.surfaceContainer,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Namaste, Pandit Ramkishan ji',
                      style: AppTypography.headlineSm.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.verified,
                            size: 14, color: AppColors.forestGreen),
                        const SizedBox(width: 4),
                        Text(
                          'Molela Studio • Master Potter',
                          style: AppTypography.bodySm.copyWith(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Switch to Buyer Mode Pill
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const CustomerHomeScreen(),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryFixed.withValues(alpha: 0.6),
                    borderRadius: AppDimensions.roundedFull,
                    border: Border.all(
                        color: AppColors.terracotta.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.storefront_outlined,
                          size: 14, color: AppColors.terracotta),
                      const SizedBox(width: 4),
                      Text(
                        'Buyer View',
                        style: AppTypography.labelSm.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.terracotta,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceLg),

          // Giant Hero Action: List New Craft with AI (Voice + Camera)
          Container(
            padding: const EdgeInsets.all(AppDimensions.spaceMd + 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.terracotta,
                  AppColors.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: AppDimensions.roundedXl,
              boxShadow: [
                BoxShadow(
                  color: AppColors.terracotta.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite.withValues(alpha: 0.2),
                        borderRadius: AppDimensions.roundedFull,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome,
                              color: AppColors.pureWhite, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'AI VOICE & VISION LISTING',
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.mic, color: AppColors.pureWhite, size: 22),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'List Your New Craft in 60 Seconds',
                  style: AppTypography.headlineSm.copyWith(
                    color: AppColors.pureWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Take a photo of your pottery, speak in your language, and AI will calculate fair prices & tell your story.',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.pureWhite.withValues(alpha: 0.9),
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceMd),

                // 48px Touch Target Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pureWhite,
                    foregroundColor: AppColors.terracotta,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDimensions.roundedLg,
                    ),
                  ),
                  onPressed: () {
                    setState(() => _currentTabIndex = 2);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Start AI Listing (Photo + Voice)',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spaceLg),

          // Overview Metrics Row
          Row(
            children: [
              Expanded(
                child: _statCard(
                  title: 'Today\'s Orders',
                  value: '3 Pending',
                  icon: Icons.local_shipping_outlined,
                  color: AppColors.terracotta,
                  onTap: () => setState(() => _currentTabIndex = 3),
                ),
              ),
              const SizedBox(width: AppDimensions.spaceSm + 4),
              Expanded(
                child: _statCard(
                  title: 'Total Payout',
                  value: '₹48,250',
                  icon: Icons.account_balance_outlined,
                  color: AppColors.forestGreen,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: AppDimensions.spaceSm + 4),
              Expanded(
                child: _statCard(
                  title: 'Live Crafts',
                  value: '14 Items',
                  icon: Icons.inventory_2_outlined,
                  color: AppColors.secondary,
                  onTap: () => setState(() => _currentTabIndex = 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceLg),

          // Orders Needing Immediate Packing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Orders to Pack & Dispatch',
                style: AppTypography.headlineSm.copyWith(fontSize: 16),
              ),
              TextButton(
                onPressed: () => setState(() => _currentTabIndex = 3),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 6),

          _orderPackItem(
            orderId: '#CM-98421',
            craftName: 'Molela Sun God Wall Plaque',
            destination: 'Bengaluru, Karnataka',
            price: '₹2,450 (Artisan Share: ₹2,107)',
            status: 'Ready for Kiln Quality Check',
          ),
          const SizedBox(height: AppDimensions.spaceSm + 4),
          _orderPackItem(
            orderId: '#CM-98422',
            craftName: 'Elephant Votive Terracotta Tile',
            destination: 'Mumbai, Maharashtra',
            price: '₹1,950 (Artisan Share: ₹1,680)',
            status: 'Pack with Straw Cushioning',
          ),
          const SizedBox(height: AppDimensions.spaceLg),

          // Direct Buyer Audio Reviews
          Text(
            'Buyer Appreciation & Notes',
            style: AppTypography.headlineSm.copyWith(fontSize: 16),
          ),
          const SizedBox(height: AppDimensions.spaceSm),

          Container(
            padding: const EdgeInsets.all(AppDimensions.spaceMd),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: AppDimensions.roundedLg,
              boxShadow: const [AppColors.cardShadow],
              border: Border.all(color: AppColors.surfaceContainerHigh),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: AppColors.warmSaffron, size: 20),
                    const Icon(Icons.star_rounded,
                        color: AppColors.warmSaffron, size: 20),
                    const Icon(Icons.star_rounded,
                        color: AppColors.warmSaffron, size: 20),
                    const Icon(Icons.star_rounded,
                        color: AppColors.warmSaffron, size: 20),
                    const Icon(Icons.star_rounded,
                        color: AppColors.warmSaffron, size: 20),
                    const Spacer(),
                    Text('2 hours ago',
                        style: AppTypography.bodySm
                            .copyWith(color: AppColors.outline)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '“The terracotta wall plaque from Molela arrived safely in Bengaluru! The clay finish and hand-carved Surya dev has such soulful energy. Thank you Ramkishan ji!”',
                  style: AppTypography.bodyMd.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '— Neha K., Connoisseur from Bengaluru',
                  style: AppTypography.bodySm.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.terracotta,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spaceXl),
        ],
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: AppDimensions.roundedLg,
          boxShadow: const [AppColors.cardShadow],
          border: Border.all(color: AppColors.surfaceContainerHigh),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTypography.labelMd.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            Text(
              title,
              style: AppTypography.bodySm.copyWith(
                fontSize: 10,
                color: AppColors.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderPackItem({
    required String orderId,
    required String craftName,
    required String destination,
    required String price,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: AppDimensions.roundedLg,
        boxShadow: const [AppColors.cardShadow],
        border: Border.all(color: AppColors.surfaceContainerHigh),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.terracotta.withValues(alpha: 0.1),
              borderRadius: AppDimensions.roundedMd,
            ),
            child: const Icon(Icons.inventory_2_outlined,
                color: AppColors.terracotta, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      orderId,
                      style: AppTypography.labelSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.terracotta,
                      ),
                    ),
                    Text(
                      destination,
                      style: AppTypography.bodySm
                          .copyWith(fontSize: 11, color: AppColors.outline),
                    ),
                  ],
                ),
                Text(
                  craftName,
                  style: AppTypography.labelMd
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  price,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.forestGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
