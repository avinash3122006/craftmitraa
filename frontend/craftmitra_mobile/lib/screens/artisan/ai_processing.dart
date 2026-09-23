import 'package:flutter/material.dart';
import '../../providers/ai_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../widgets/ai_loading.dart';
import 'ai_preview.dart';

class AIProcessingScreen extends StatefulWidget {
  final ProductProvider productProvider;
  final AIProvider aiProvider;

  const AIProcessingScreen({
    super.key,
    required this.productProvider,
    required this.aiProvider,
  });

  @override
  State<AIProcessingScreen> createState() => _AIProcessingScreenState();
}

class _AIProcessingScreenState extends State<AIProcessingScreen> {
  @override
  void initState() {
    super.initState();
    _startAnalysis();
  }

  Future<void> _startAnalysis() async {
    await widget.aiProvider.runAIAnalysis(
      imageSource: widget.aiProvider.capturedImagePath ?? '',
      voiceDescription: widget.aiProvider.recordedVoiceText ?? '',
    );

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => AIPreviewScreen(
            productProvider: widget.productProvider,
            aiProvider: widget.aiProvider,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: AppDimensions.paddingPage,
            child: AnimatedBuilder(
              animation: widget.aiProvider,
              builder: (context, _) {
                return AILoadingWidget(
                  currentStep: widget.aiProvider.processingStep,
                  progress: widget.aiProvider.processingProgress,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
