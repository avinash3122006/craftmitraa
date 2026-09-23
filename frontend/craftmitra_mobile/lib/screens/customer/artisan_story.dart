import 'package:flutter/material.dart';
import '../../models/artisan_model.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../widgets/story_card.dart';

class ArtisanStoryScreen extends StatelessWidget {
  final ArtisanModel? artisan;

  const ArtisanStoryScreen({super.key, this.artisan});

  @override
  Widget build(BuildContext context) {
    final maker = artisan ??
        ArtisanModel(
          id: 'art-001',
          name: 'Pandit Ramkishan Prajapati',
          craftType: 'Molela Terracotta Art',
          village: 'Molela',
          state: 'Rajasthan',
          bio: 'Preserving 300-year-old terracotta sun-relief plaques using Banas river clay.',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
          coverImageUrl: 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80',
          awards: ['National Craft Master 2018'],
          audioStoryTitle: 'Echoes of Molela River Clay',
          audioDurationSeconds: 165,
        );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Oral Heritage Story'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.paddingPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: AppDimensions.roundedLg,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    maker.coverImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMd),

              Text(
                maker.audioStoryTitle,
                style: AppTypography.headlineMd.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Narrated by ${maker.name} • ${maker.fullLocation}',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.terracotta,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              StoryCard(
                title: 'The Legend of the Molela Potters',
                story:
                    'Centuries ago, a blind potter had a dream where Dharmaraja asked him to sculpt votive clay plaques using Banas river mud. In the morning, the potter’s vision returned. Since then, each generational plaque is sculpted without molds by the Kumhar community of Molela.',
                artisanName: maker.name,
                craftHeritage: maker.craftType,
                durationSeconds: maker.audioDurationSeconds,
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              Text(
                'Generational Technique Notes',
                style: AppTypography.headlineSm.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(AppDimensions.spaceMd),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.cardShadow],
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: Column(
                  children: [
                    _bulletRow(
                      'Clay Sourcing',
                      'Collected exclusively after summer monsoons from the silt deposits of the Banas river basin.',
                    ),
                    const Divider(),
                    _bulletRow(
                      'Thumb Sculpting',
                      'No wheel or casting mold is ever used. Hollow votive shapes are hand-pinched using fingers.',
                    ),
                    const Divider(),
                    _bulletRow(
                      'Natural Mineral Colors',
                      'Polished using Geru (red ochre) and Plaster-of-Paris chalk, fixed with tree sap gum.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bulletRow(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: AppColors.terracotta),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTypography.bodySm.copyWith(color: AppColors.onSurface, fontSize: 13),
                children: [
                  TextSpan(text: '$title: ', style: const TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: desc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
