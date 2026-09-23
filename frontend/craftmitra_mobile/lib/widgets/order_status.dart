import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../theme/colors.dart';
import '../theme/dimensions.dart';
import '../theme/typography.dart';

class OrderStatusWidget extends StatelessWidget {
  final List<TrackingStep> steps;

  const OrderStatusWidget({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: AppDimensions.roundedLg,
        boxShadow: const [AppColors.cardShadow],
        border: Border.all(color: AppColors.surfaceContainerHigh, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_shipping_outlined,
                color: AppColors.terracotta,
                size: 22,
              ),
              const SizedBox(width: AppDimensions.spaceSm),
              Text(
                'Handcrafted Journey',
                style: AppTypography.headlineSm.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceMd),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              final step = steps[index];
              final isLast = index == steps.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step indicator column with vertical connector line
                    Column(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: step.isCompleted
                                ? AppColors.forestGreen
                                : step.isCurrent
                                    ? AppColors.terracotta
                                    : AppColors.surfaceContainerHigh,
                            border: Border.all(
                              color: step.isCurrent
                                  ? AppColors.terracotta
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: step.isCompleted
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: AppColors.pureWhite,
                                  )
                                : step.isCurrent
                                    ? Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.pureWhite,
                                        ),
                                      )
                                    : null,
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: step.isCompleted
                                  ? AppColors.forestGreen
                                  : AppColors.surfaceContainerHigh,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: AppDimensions.spaceSm + 4),

                    // Step title, description and timestamp
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: isLast ? 0 : AppDimensions.spaceMd + 2,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    step.title,
                                    style: AppTypography.labelMd.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: step.isCurrent
                                          ? AppColors.terracotta
                                          : AppColors.onSurface,
                                    ),
                                  ),
                                ),
                                Text(
                                  step.date,
                                  style: AppTypography.bodySm.copyWith(
                                    fontSize: 11,
                                    color: AppColors.outline,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              step.description,
                              style: AppTypography.bodySm.copyWith(
                                fontSize: 12,
                                color: AppColors.onSurfaceVariant,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
