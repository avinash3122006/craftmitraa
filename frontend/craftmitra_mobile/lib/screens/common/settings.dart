import 'package:flutter/material.dart';
import '../../providers/auth_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../artisan/artisan_home.dart';
import '../auth/role_selection_screen.dart';

class SettingsScreen extends StatelessWidget {
  final AuthProvider? authProvider;

  const SettingsScreen({super.key, this.authProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile & Preferences'),
      ),
      body: SafeArea(
        child: ListView(
          padding: AppDimensions.paddingPage,
          children: [
            // User Card
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
                    radius: 30,
                    backgroundColor: AppColors.surfaceContainer,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aarav Sharma',
                          style: AppTypography.headlineSm.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '+91 98765 43210',
                          style: AppTypography.bodySm.copyWith(color: AppColors.outline),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Connoisseur • Supporting 8 Artisan Families',
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
            ),
            const SizedBox(height: AppDimensions.spaceLg),

            // Persona Switcher Feature Card
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              decoration: BoxDecoration(
                color: AppColors.terracotta.withOpacity(0.08),
                borderRadius: AppDimensions.roundedLg,
                border: Border.all(color: AppColors.terracotta.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.terracotta,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.brush_rounded, color: AppColors.pureWhite, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Experience Artisan Studio',
                          style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Switch to Karigar mode to test camera & voice multimodal craft listing.',
                          style: AppTypography.bodySm.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const ArtisanHomeScreen(),
                        ),
                      );
                    },
                    child: const Text('Switch', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLg),

            // Settings Menu List
            Text(
              'Account & Heritage Settings',
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
                    title: const Text('App Language'),
                    subtitle: const Text('English (Indian)'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.location_on_outlined, color: AppColors.terracotta),
                    title: const Text('Saved Delivery Addresses'),
                    subtitle: const Text('2 saved addresses in Bengaluru'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.handshake_outlined, color: AppColors.forestGreen),
                    title: const Text('Fair Trade Transparency Report'),
                    subtitle: const Text('Verify 85%+ direct payout flow'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.swap_horiz_rounded, color: AppColors.outline),
                    title: const Text('Role Selector Screen'),
                    subtitle: const Text('Choose Artisan vs Connoisseur role'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    onTap: () {
                      Navigator.of(context).push(
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
