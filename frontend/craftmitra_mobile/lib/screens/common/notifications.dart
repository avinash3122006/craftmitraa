import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Artisan Order Progress',
        'desc': 'Pandit Ramkishan has finished kiln firing your Sun God plaque. Packaging has begun in Molela.',
        'time': '10 mins ago',
        'icon': Icons.local_shipping_outlined,
        'color': AppColors.terracotta,
      },
      {
        'title': 'Direct Payout Credited',
        'desc': '₹2,107 has been released to Pandit Ramkishan’s SBI account.',
        'time': '2 hours ago',
        'icon': Icons.account_balance_wallet_outlined,
        'color': AppColors.forestGreen,
      },
      {
        'title': 'New Audio Heritage Story',
        'desc': 'Shanti Devi Bunker from Chanderi shared a new audio recording on gold zari weaving history.',
        'time': '1 day ago',
        'icon': Icons.mic_none_rounded,
        'color': AppColors.secondary,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Notifications')),
      body: SafeArea(
        child: ListView.builder(
          padding: AppDimensions.paddingPage,
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final n = notifications[index];
            return Container(
              margin: const EdgeInsets.only(bottom: AppDimensions.spaceSm + 4),
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: AppDimensions.roundedLg,
                boxShadow: const [AppColors.cardShadow],
                border: Border.all(color: AppColors.surfaceContainerHigh),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (n['color'] as Color).withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 22),
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
                              n['title'] as String,
                              style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              n['time'] as String,
                              style: AppTypography.bodySm.copyWith(fontSize: 11, color: AppColors.outline),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          n['desc'] as String,
                          style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
