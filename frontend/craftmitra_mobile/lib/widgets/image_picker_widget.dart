import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/dimensions.dart';
import '../theme/typography.dart';

class ImagePickerWidget extends StatelessWidget {
  final String? selectedImageUrl;
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const ImagePickerWidget({
    super.key,
    this.selectedImageUrl,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: AppDimensions.roundedLg,
        boxShadow: const [AppColors.cardShadow],
        border: Border.all(
          color: selectedImageUrl != null
              ? AppColors.terracotta
              : AppColors.outlineVariant,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.photo_camera_back_outlined,
                color: AppColors.terracotta,
                size: 22,
              ),
              const SizedBox(width: AppDimensions.spaceSm),
              Text(
                'Craft Photography',
                style: AppTypography.headlineSm.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Place your craft under natural daylight. AI will automatically inspect clay texture, engravings & colors.',
            style: AppTypography.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMd),

          if (selectedImageUrl != null) ...[
            ClipRRect(
              borderRadius: AppDimensions.roundedMd,
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      selectedImageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.forestGreen,
                        borderRadius: AppDimensions.roundedFull,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, size: 14, color: AppColors.pureWhite),
                          SizedBox(width: 4),
                          Text(
                            'Photo Ready',
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceSm + 4),
          ],

          // Action Buttons: Camera & Gallery (Min 48px touch height)
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onCameraTap,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.terracotta,
                    side: const BorderSide(color: AppColors.terracotta, width: 1.5),
                  ),
                  icon: const Icon(Icons.camera_alt_outlined, size: 20),
                  label: const Text('Take Photo'),
                ),
              ),
              const SizedBox(width: AppDimensions.spaceSm + 4),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onGalleryTap,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.onSurface,
                    side: const BorderSide(color: AppColors.outline, width: 1),
                  ),
                  icon: const Icon(Icons.photo_library_outlined, size: 20),
                  label: const Text('Choose Photo'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
