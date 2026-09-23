import 'package:flutter/material.dart';
import '../../models/order_model.dart';
import '../../providers/order_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../widgets/order_status.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderProvider? orderProvider;

  const OrderTrackingScreen({
    super.key,
    this.orderProvider,
  });

  @override
  Widget build(BuildContext context) {
    final orders = orderProvider?.orders ?? [];

    if (orders.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Order Tracking')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.inventory_2_outlined, size: 64, color: AppColors.outline),
              const SizedBox(height: AppDimensions.spaceMd),
              Text(
                'No orders placed yet',
                style: AppTypography.headlineSm.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Explore the marketplace and support traditional crafts',
                style: AppTypography.bodySm,
              ),
            ],
          ),
        ),
      );
    }

    final activeOrder = orders.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Track Handcrafted Order'),
      ),
      body: SafeArea(
        child: ListView(
          padding: AppDimensions.paddingPage,
          children: [
            // Order Header Card
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        activeOrder.formattedOrderId,
                        style: AppTypography.headlineSm.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.terracotta.withOpacity(0.12),
                          borderRadius: AppDimensions.roundedFull,
                        ),
                        child: Text(
                          'Handcrafting in Progress',
                          style: AppTypography.labelSm.copyWith(
                            color: AppColors.terracotta,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Direct Artisan Payout: ₹${activeOrder.artisanContribution.toStringAsFixed(0)} (85%+) secured for maker',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.forestGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Divider(height: 18),
                  Row(
                    children: [
                      const Icon(Icons.home_outlined, size: 16, color: AppColors.outline),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          activeOrder.deliveryAddress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.bodySm.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLg),

            // Visual Tracking Journey
            OrderStatusWidget(steps: activeOrder.trackingSteps),
            const SizedBox(height: AppDimensions.spaceLg),

            // Note to Artisan card
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: AppDimensions.roundedLg,
                border: Border.all(color: AppColors.surfaceContainerHigh),
              ),
              child: Row(
                children: [
                  const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.terracotta, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Send Gratitude to Artisan',
                          style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Share a voice note or message thanking the maker for their craftsmanship.',
                          style: AppTypography.bodySm.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: AppColors.terracotta),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Message sent to the artisan studio!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
