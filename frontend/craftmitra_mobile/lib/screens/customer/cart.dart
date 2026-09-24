import 'package:flutter/material.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import 'checkout.dart';

class CartScreen extends StatelessWidget {
  final CartProvider cartProvider;
  final OrderProvider? orderProvider;

  const CartScreen({
    super.key,
    required this.cartProvider,
    this.orderProvider,
  });

  @override
  Widget build(BuildContext context) {
    final items = cartProvider.items;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Craft Basket'),
        actions: [
          if (items.isNotEmpty)
            TextButton(
              onPressed: () {
                cartProvider.clearCart();
              },
              child: const Text('Clear', style: TextStyle(color: AppColors.outline)),
            ),
        ],
      ),
      body: SafeArea(
        child: items.isEmpty
            ? Center(
                child: Padding(
                  padding: AppDimensions.paddingPage,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 48,
                          color: AppColors.outline,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceLg),
                      Text(
                        'Your Craft Basket is Empty',
                        style: AppTypography.headlineSm.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceSm),
                      Text(
                        'Support rural artisans across India by adding their authentic creations.',
                        textAlign: TextAlign.center,
                        style: AppTypography.bodyMd,
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: AppDimensions.paddingPage,
                      children: [
                        // Direct Artisan Support Impact Callout
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.spaceMd),
                          decoration: BoxDecoration(
                            color: AppColors.tertiaryFixed.withValues(alpha: 0.4),
                            borderRadius: AppDimensions.roundedLg,
                            border: Border.all(color: AppColors.forestGreen.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.volunteer_activism_rounded, color: AppColors.tertiary, size: 24),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Direct Fair-Trade Impact',
                                      style: AppTypography.labelMd.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.tertiary,
                                      ),
                                    ),
                                    Text(
                                      '₹${cartProvider.totalArtisanShare.toStringAsFixed(0)} goes directly to rural artisan families from this order.',
                                      style: AppTypography.bodySm.copyWith(
                                        color: AppColors.onSurface,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),

                        // Item List
                        ...items.map((cartItem) {
                          final product = cartItem.product;
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
                                    width: 80,
                                    height: 80,
                                    child: Image.network(
                                      product.images.first,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppDimensions.spaceSm + 4),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography.labelMd.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'By ${product.artisanName}',
                                        style: AppTypography.bodySm.copyWith(
                                          fontSize: 11,
                                          color: AppColors.outline,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '₹${cartItem.totalPrice.toStringAsFixed(0)}',
                                        style: AppTypography.headlineSm.copyWith(
                                          color: AppColors.terracotta,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Quantity Controls
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainerLow,
                                    borderRadius: AppDimensions.roundedFull,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove, size: 16),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                        onPressed: () {
                                          cartProvider.decrementQuantity(product.id);
                                        },
                                      ),
                                      Text(
                                        '${cartItem.quantity}',
                                        style: AppTypography.labelSm.copyWith(fontWeight: FontWeight.w700),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add, size: 16),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                        onPressed: () {
                                          cartProvider.incrementQuantity(product.id);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: AppDimensions.spaceSm),

                        // Bill Details Card
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.spaceMd),
                          decoration: BoxDecoration(
                            color: AppColors.pureWhite,
                            borderRadius: AppDimensions.roundedLg,
                            border: Border.all(color: AppColors.surfaceContainerHigh),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price Summary',
                                style: AppTypography.headlineSm.copyWith(fontSize: 15),
                              ),
                              const SizedBox(height: AppDimensions.spaceSm),
                              _summaryRow('Item Subtotal', '₹${cartProvider.subtotal.toStringAsFixed(0)}'),
                              _summaryRow('Eco-friendly Straw Cushioning', 'FREE'),
                              _summaryRow(
                                'Rural Surface Delivery',
                                cartProvider.shippingFee == 0 ? 'FREE' : '₹${cartProvider.shippingFee.toStringAsFixed(0)}',
                              ),
                              _summaryRow('Artisan Welfare Fund', '₹${cartProvider.fairTradeContribution.toStringAsFixed(0)}'),
                              const Divider(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Grand Total',
                                    style: AppTypography.headlineSm.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '₹${cartProvider.grandTotal.toStringAsFixed(0)}',
                                    style: AppTypography.headlineSm.copyWith(
                                      color: AppColors.terracotta,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
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

                  // Bottom Proceed CTA
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.margin),
                    decoration: const BoxDecoration(
                      color: AppColors.pureWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(34, 34, 34, 0.08),
                          blurRadius: 12,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                cartProvider: cartProvider,
                                orderProvider: orderProvider,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Proceed to Checkout (₹${cartProvider.grandTotal.toStringAsFixed(0)})'),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
          Text(value, style: AppTypography.labelSm.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
