import 'package:flutter/material.dart';
import '../../providers/ai_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../widgets/voice_button.dart';
import 'ai_processing.dart';

class VoiceInputScreen extends StatefulWidget {
  final ProductProvider productProvider;
  final AIProvider aiProvider;

  const VoiceInputScreen({
    super.key,
    required this.productProvider,
    required this.aiProvider,
  });

  @override
  State<VoiceInputScreen> createState() => _VoiceInputScreenState();
}

class _VoiceInputScreenState extends State<VoiceInputScreen> {
  bool _isRecording = false;
  final TextEditingController _transcriptController = TextEditingController();

  final List<String> _languages = [
    'Hindi (हिन्दी)',
    'Rajasthani (राजस्थानी)',
    'Maithili (मैथिली)',
    'Bengali (বাংলা)',
    'Odia (ଓଡ଼ିଆ)',
    'English',
  ];

  @override
  void initState() {
    super.initState();
    _transcriptController.text = widget.aiProvider.recordedVoiceText ??
        'Yeh Banas nadi ki mitti se bana haath ka sacred hathi relief plaque hai. Do din lag gaye sukhane aur natural geru lagane me. Isme 16 ghante ka haath ka kaam hai.';
  }

  @override
  void dispose() {
    _transcriptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('AI Listing • Step 2 of 3'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.paddingPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Stepper
              ClipRRect(
                borderRadius: AppDimensions.roundedFull,
                child: const LinearProgressIndicator(
                  value: 0.66,
                  backgroundColor: AppColors.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.terracotta),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMd),

              Text(
                'Step 2: Voice Your Craft Heritage',
                style: AppTypography.headlineSm.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'No typing needed. Just speak about your work, materials, and time taken in your mother tongue.',
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: AppDimensions.spaceMd),

              // Language selector pill
              Row(
                children: [
                  const Icon(Icons.language_rounded, size: 18, color: AppColors.terracotta),
                  const SizedBox(width: 6),
                  Text('Language:', style: AppTypography.labelSm),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: widget.aiProvider.selectedLanguage.contains('(')
                        ? widget.aiProvider.selectedLanguage
                        : 'Hindi (हिन्दी)',
                    underline: const SizedBox(),
                    items: _languages.map((l) {
                      return DropdownMenuItem(value: l, child: Text(l, style: const TextStyle(fontSize: 13)));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        widget.aiProvider.setLanguage(val);
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // Centered Pulsing Tactile Voice Button
              Center(
                child: VoiceButton(
                  isRecording: _isRecording,
                  onTap: () {
                    setState(() {
                      _isRecording = !_isRecording;
                      if (!_isRecording) {
                        _transcriptController.text =
                            'Yeh Molela Banas nadi ki mitti se bana haath ka hathi wall relief hai. Isme pure geru rang aur acacia gond use kiya hai. Kul 16 ghante ka shram laga hai.';
                        widget.aiProvider.setRecordedVoice(_transcriptController.text);
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // Transcript Preview Box (Accessible & high contrast)
              Text(
                'Live Speech-to-Text Transcription',
                style: AppTypography.headlineSm.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.pressedShadow],
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: TextField(
                  controller: _transcriptController,
                  maxLines: 4,
                  style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your voice note will appear here as text...',
                    contentPadding: EdgeInsets.all(AppDimensions.spaceMd),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // AI Multimodal CTA Button (Min 48px touch target)
              ElevatedButton(
                onPressed: () {
                  widget.aiProvider.setRecordedVoice(_transcriptController.text);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AIProcessingScreen(
                        productProvider: widget.productProvider,
                        aiProvider: widget.aiProvider,
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_awesome_rounded, size: 20),
                    SizedBox(width: 8),
                    Text('Run Multimodal Craft Analysis'),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              Center(
                child: Text(
                  'AI will generate marketing story, calculate fair price & GI tags',
                  style: AppTypography.bodySm.copyWith(
                    fontSize: 11,
                    color: AppColors.outline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
