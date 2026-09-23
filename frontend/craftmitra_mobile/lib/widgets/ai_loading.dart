import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/dimensions.dart';
import '../theme/typography.dart';

class AILoadingWidget extends StatelessWidget {
  final String currentStep;
  final double progress;

  const AILoadingWidget({
    super.key,
    required this.currentStep,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceLg),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: AppDimensions.roundedLg,
        boxShadow: const [AppColors.cardShadow],
        border: Border.all(color: AppColors.surfaceContainerHigh, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular Progress Indicator with Terracotta Hue
          SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress > 0 ? progress : null,
                  strokeWidth: 5,
                  backgroundColor: AppColors.surfaceContainerHighest,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.terracotta),
                ),
                const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.terracotta,
                  size: 28,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spaceLg),

          // Main Header
          Text(
            'CraftMitra Multimodal AI',
            style: AppTypography.headlineSm.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSm),

          // Current Processing Step
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              currentStep.isNotEmpty ? currentStep : 'Analyzing your craft creation...',
              key: ValueKey(currentStep),
              textAlign: TextAlign.center,
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.terracotta,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMd),

          // Progress bar
          ClipRRect(
            borderRadius: AppDimensions.roundedFull,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.surfaceContainer,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.terracotta),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSm + 2),

          Text(
            'Extracting heritage roots, handcrafting hours & fair pricing',
            textAlign: TextAlign.center,
            style: AppTypography.bodySm.copyWith(
              fontSize: 12,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
