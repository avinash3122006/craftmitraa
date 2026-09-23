import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../auth/role_selection_screen.dart';

class ArtisanProfileManagementScreen extends StatelessWidget {
  const ArtisanProfileManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Artisan Studio Profile'),
      ),
      body: SafeArea(
        child: ListView(
          padding: AppDimensions.paddingPage,
          children: [
            // Profile Card
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
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.surfaceContainer,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Pandit Ramkishan',
                              style: AppTypography.headlineSm.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.verified, size: 16, color: AppColors.forestGreen),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Master Terracotta Sculptor',
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.terracotta,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Molela Village, Rajsamand, Rajasthan',
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.onSurfaceVariant,
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

            // Direct Bank Account for Payouts
            Text(
              'Direct-to-Bank Payout Account',
              style: AppTypography.headlineSm.copyWith(fontSize: 16),
            ),
            const SizedBox(height: AppDimensions.spaceSm),

            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: AppDimensions.roundedLg,
                boxShadow: const [AppColors.cardShadow],
                border: Border.all(color: AppColors.forestGreen.withOpacity(0.4), width: 1.5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.forestGreen.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.account_balance_rounded, color: AppColors.forestGreen, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'State Bank of India (Verified)',
                              style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'A/C: *******4321 • IFSC: SBIN0001245',
                              style: AppTypography.bodySm.copyWith(fontSize: 12, color: AppColors.outline),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.check_circle_rounded, color: AppColors.forestGreen, size: 20),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Artisan Direct UPI:',
                        style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                      Text(
                        'ramkishan.clay@sbi',
                        style: AppTypography.labelSm.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLg),

            // Studio Settings
            Text(
              'Studio Preferences',
              style: AppTypography.headlineSm.copyWith(fontSize: 16),
            ),
            const SizedBox(height: AppDimensions.spaceSm),

            Container(
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: AppDimensions.roundedLg,
                border: Border.all(color: AppColors.surfaceContainerHigh),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.language_rounded, color: AppColors.terracotta),
                    title: const Text('Voice & App Language'),
                    subtitle: const Text('हिन्दी (Hindi) • राजस्थानी (Rajasthani)'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.badge_outlined, color: AppColors.secondary),
                    title: const Text('GI Certification Documents'),
                    subtitle: const Text('Molela Terracotta GI No: 082/2012'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.headset_mic_outlined, color: AppColors.forestGreen),
                    title: const Text('Rural Artisan Helpline'),
                    subtitle: const Text('Toll Free: 1800-200-CRAFT (Toll free)'),
                    trailing: const Icon(Icons.call, size: 16, color: AppColors.forestGreen),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.swap_horiz_rounded, color: AppColors.terracotta),
                    title: const Text('Switch Role'),
                    subtitle: const Text('Switch to Connoisseur / Buyer Mode'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const RoleSelectionScreen(),
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
