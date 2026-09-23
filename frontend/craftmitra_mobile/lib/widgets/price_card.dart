import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/dimensions.dart';
import '../theme/typography.dart';

class PriceCard extends StatelessWidget {
  final double currentPrice;
  final double fairPriceMin;
  final double fairPriceMax;
  final int laborHours;
  final double artisanSharePercent;

  const PriceCard({
    super.key,
    required this.currentPrice,
    required this.fairPriceMin,
    required this.fairPriceMax,
    this.laborHours = 18,
    this.artisanSharePercent = 85.0,
  });

  @override
  Widget build(BuildContext context) {
    final artisanEarning = (currentPrice * artisanSharePercent) / 100;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: AppDimensions.roundedLg,
        boxShadow: const [AppColors.cardShadow],
        border: Border.all(color: AppColors.surfaceContainerHigh, width: 1),
      ),
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryFixed.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.balance_rounded,
                  color: AppColors.tertiary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceSm + 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Fair-Price Guarantee',
                      style: AppTypography.headlineSm.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Direct-to-Artisan verified pricing formula',
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
          const SizedBox(height: AppDimensions.spaceMd),

          // Fair price benchmark range
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: AppDimensions.roundedMd,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended Fair Range:',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '₹${fairPriceMin.toStringAsFixed(0)} - ₹${fairPriceMax.toStringAsFixed(0)}',
                      style: AppTypography.labelMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.tertiary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Manual Crafting Time:',
                      style: AppTypography.bodySm.copyWith(
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '$laborHours hours of hand-shaping',
                      style: AppTypography.labelSm.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSm + 4),

          // Payout breakdown
          Row(
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                color: AppColors.forestGreen,
                size: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${artisanSharePercent.toStringAsFixed(0)}% (₹${artisanEarning.toStringAsFixed(0)}) goes directly to the maker’s bank account',
                  style: AppTypography.bodySm.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.forestGreen,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
