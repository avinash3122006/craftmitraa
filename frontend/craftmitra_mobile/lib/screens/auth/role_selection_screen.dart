import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../artisan/artisan_home.dart';
import '../customer/customer_home.dart';

class RoleSelectionScreen extends StatelessWidget {
  final AuthProvider? authProvider;

  const RoleSelectionScreen({super.key, this.authProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: const Text('Choose Your Role'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppDimensions.paddingPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How will you use\nCraftMitra AI?',
                style: AppTypography.headlineLg.copyWith(
                  height: 1.2,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              Text(
                'Select your mode. You can switch between roles at any time.',
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // Option 1: Modern Consumer / Buyer
              _RoleCard(
                title: 'I am a Craft Connoisseur / Buyer',
                subtitle: 'Discover authentic GI-certified handcrafts, listen to oral artisan stories, and support rural makers directly.',
                icon: Icons.storefront_outlined,
                accentColor: AppColors.terracotta,
                badgeText: 'Explore & Buy',
                badgeColor: AppColors.terracotta,
                onTap: () {
                  authProvider?.setRole(UserRole.customer);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const CustomerHomeScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppDimensions.spaceMd),

              // Option 2: Rural Artisan / Karigar
              _RoleCard(
                title: 'I am an Artisan / Karigar',
                subtitle: 'List your handcrafted art in seconds using camera & voice input in your regional mother tongue. Get fair prices.',
                icon: Icons.brush_outlined,
                accentColor: AppColors.forestGreen,
                badgeText: 'Voice & Camera AI',
                badgeColor: AppColors.forestGreen,
                onTap: () {
                  authProvider?.setRole(UserRole.artisan);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const ArtisanHomeScreen(),
                    ),
                  );
                },
              ),

              const Spacer(),

              // Trust marker footer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.spaceMd),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      color: AppColors.forestGreen,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Direct-to-Artisan Fair Trade: 85%+ payout directly credited to artisans.',
                        style: AppTypography.bodySm.copyWith(
                          fontSize: 12,
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceSm),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final String badgeText;
  final Color badgeColor;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.badgeText,
    required this.badgeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: AppDimensions.roundedLg,
        boxShadow: const [AppColors.cardShadow],
        border: Border.all(color: AppColors.surfaceContainerHigh, width: 1.2),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppDimensions.roundedLg,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppDimensions.roundedLg,
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spaceMd + 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        borderRadius: AppDimensions.roundedMd,
                      ),
                      child: Icon(icon, color: accentColor, size: 28),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.12),
                        borderRadius: AppDimensions.roundedFull,
                      ),
                      child: Text(
                        badgeText,
                        style: AppTypography.labelSm.copyWith(
                          color: badgeColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spaceMd),

                Text(
                  title,
                  style: AppTypography.headlineSm.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: AppTypography.bodySm.copyWith(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceMd),

                Row(
                  children: [
                    Text(
                      'Continue',
                      style: AppTypography.labelMd.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: accentColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
