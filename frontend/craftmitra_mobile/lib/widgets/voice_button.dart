import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/dimensions.dart';
import '../theme/typography.dart';

class VoiceButton extends StatefulWidget {
  final bool isRecording;
  final VoidCallback onTap;
  final String label;

  const VoiceButton({
    super.key,
    required this.isRecording,
    required this.onTap,
    this.label = 'Tap & Speak in your Native Language',
  });

  @override
  State<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends State<VoiceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant VoiceButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording && !oldWidget.isRecording) {
      _animController.repeat(reverse: true);
    } else if (!widget.isRecording && oldWidget.isRecording) {
      _animController.stop();
      _animController.reset();
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Transform.scale(
                scale: widget.isRecording ? _scaleAnimation.value : 1.0,
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: widget.isRecording
                        ? AppColors.error
                        : AppColors.terracotta,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (widget.isRecording
                                ? AppColors.error
                                : AppColors.terracotta)
                            .withOpacity(0.35),
                        blurRadius: widget.isRecording ? 20 : 12,
                        spreadRadius: widget.isRecording ? 4 : 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      widget.isRecording ? Icons.mic_rounded : Icons.mic_none_rounded,
                      size: 36,
                      color: AppColors.pureWhite,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppDimensions.spaceMd),

        // Text label
        Text(
          widget.isRecording ? 'Listening... Speak now' : widget.label,
          textAlign: TextAlign.center,
          style: AppTypography.labelMd.copyWith(
            fontWeight: FontWeight.w600,
            color: widget.isRecording ? AppColors.error : AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.isRecording
              ? 'Tell about clay, time taken, and craft significance'
              : 'Hindi, Rajasthani, Maithili, Odia & English supported',
          textAlign: TextAlign.center,
          style: AppTypography.bodySm.copyWith(
            fontSize: 12,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
