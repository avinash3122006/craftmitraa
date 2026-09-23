import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';

class ArtisanOrdersScreen extends StatefulWidget {
  const ArtisanOrdersScreen({super.key});

  @override
  State<ArtisanOrdersScreen> createState() => _ArtisanOrdersScreenState();
}

class _ArtisanOrdersScreenState extends State<ArtisanOrdersScreen> {
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#CM-98421',
      'item': 'Molela Sun God Wall Plaque',
      'customer': 'Neha K., Bengaluru',
      'payout': '₹2,107',
      'status': 'Packaging Needed',
      'isPacked': false,
      'date': '21 Sep 2026',
    },
    {
      'id': '#CM-98422',
      'item': 'Elephant Votive Terracotta Tile',
      'customer': 'Rajesh M., Mumbai',
      'payout': '₹1,680',
      'status': 'Packaging Needed',
      'isPacked': false,
      'date': '22 Sep 2026',
    },
    {
      'id': '#CM-98390',
      'item': 'Terracotta Water Pitcher with Folk Carving',
      'customer': 'Ananya D., Pune',
      'payout': '₹1,450',
      'status': 'Dispatched via India Post',
      'isPacked': true,
      'date': '19 Sep 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Orders to Fulfill'),
      ),
      body: SafeArea(
        child: ListView(
          padding: AppDimensions.paddingPage,
          children: [
            // Payout reminder
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              decoration: BoxDecoration(
                color: AppColors.tertiaryFixed.withOpacity(0.4),
                borderRadius: AppDimensions.roundedLg,
                border: Border.all(color: AppColors.forestGreen.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_wallet_rounded, color: AppColors.tertiary, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Direct Payout Guarantee',
                          style: AppTypography.labelMd.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.tertiary,
                          ),
                        ),
                        Text(
                          'Next payout of ₹5,237 scheduled for Friday directly into SBI Account **4321.',
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
            const SizedBox(height: AppDimensions.spaceLg),

            Text(
              'Orders Awaiting Packing & Dispatch',
              style: AppTypography.headlineSm.copyWith(fontSize: 16),
            ),
            const SizedBox(height: AppDimensions.spaceSm),

            ..._orders.map((o) {
              final isPacked = o['isPacked'] as bool;
              return Container(
                margin: const EdgeInsets.only(bottom: AppDimensions.spaceMd),
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
                          o['id'] as String,
                          style: AppTypography.labelMd.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.terracotta,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isPacked
                                ? AppColors.forestGreen.withOpacity(0.12)
                                : AppColors.secondaryFixed.withOpacity(0.4),
                            borderRadius: AppDimensions.roundedFull,
                          ),
                          child: Text(
                            o['status'] as String,
                            style: AppTypography.labelSm.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: isPacked ? AppColors.forestGreen : AppColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      o['item'] as String,
                      style: AppTypography.headlineSm.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Buyer: ${o['customer']} • Ordered on ${o['date']}',
                      style: AppTypography.bodySm.copyWith(color: AppColors.outline, fontSize: 12),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Artisan Net Share',
                              style: AppTypography.bodySm.copyWith(fontSize: 11, color: AppColors.outline),
                            ),
                            Text(
                              o['payout'] as String,
                              style: AppTypography.headlineSm.copyWith(
                                color: AppColors.forestGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        if (!isPacked)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(140, 42),
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                            ),
                            onPressed: () {
                              setState(() {
                                o['isPacked'] = true;
                                o['status'] = 'Packed • Pickup Scheduled';
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.forestGreen,
                                  content: Text('Order ${o['id']} marked as packed! Courier notified.'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.check, size: 16),
                            label: const Text('Mark Packed'),
                          )
                        else
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(140, 42),
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.qr_code_scanner_rounded, size: 16),
                            label: const Text('Postal Label'),
                          ),
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
