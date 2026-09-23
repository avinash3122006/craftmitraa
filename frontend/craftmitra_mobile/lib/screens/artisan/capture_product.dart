import 'package:flutter/material.dart';
import '../../providers/ai_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../widgets/image_picker_widget.dart';
import 'voice_input.dart';

class CaptureProductScreen extends StatefulWidget {
  final ProductProvider productProvider;
  final AIProvider aiProvider;

  const CaptureProductScreen({
    super.key,
    required this.productProvider,
    required this.aiProvider,
  });

  @override
  State<CaptureProductScreen> createState() => _CaptureProductScreenState();
}

class _CaptureProductScreenState extends State<CaptureProductScreen> {
  String? _selectedImage;

  final List<String> _sampleCraftPhotos = [
    'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&w=800&q=80',
  ];

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.aiProvider.capturedImagePath ?? _sampleCraftPhotos.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('AI Listing • Step 1 of 3'),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppDimensions.paddingPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress stepper
              ClipRRect(
                borderRadius: AppDimensions.roundedFull,
                child: const LinearProgressIndicator(
                  value: 0.33,
                  backgroundColor: AppColors.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.terracotta),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMd),

              Text(
                'Step 1: Capture Craft Photo',
                style: AppTypography.headlineSm.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Natural daylight captures the authentic textures of clay, weave, and engravings for AI analysis.',
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // Image Picker Component
              ImagePickerWidget(
                selectedImageUrl: _selectedImage,
                onCameraTap: () {
                  setState(() {
                    _selectedImage = _sampleCraftPhotos[0];
                  });
                  widget.aiProvider.setCapturedImage(_selectedImage!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Craft photo captured under natural lighting')),
                  );
                },
                onGalleryTap: () {
                  setState(() {
                    _selectedImage = _sampleCraftPhotos[1];
                  });
                  widget.aiProvider.setCapturedImage(_selectedImage!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Selected high-resolution photo from gallery')),
                  );
                },
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // Quick sample selector
              Text(
                'Or test with a sample craft photo:',
                style: AppTypography.labelSm.copyWith(color: AppColors.outline),
              ),
              const SizedBox(height: 8),
              Row(
                children: _sampleCraftPhotos.map((url) {
                  final isSelected = _selectedImage == url;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedImage = url);
                      widget.aiProvider.setCapturedImage(url);
                    },
                    child: Container(
                      width: 64,
                      height: 64,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: AppDimensions.roundedDefault,
                        border: Border.all(
                          color: isSelected ? AppColors.terracotta : AppColors.surfaceContainerHigh,
                          width: 2.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: AppDimensions.roundedDefault,
                        child: Image.network(url, fit: BoxFit.cover),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              // Next CTA Button (Minimum 48px touch target)
              ElevatedButton(
                onPressed: () {
                  if (_selectedImage != null) {
                    widget.aiProvider.setCapturedImage(_selectedImage!);
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => VoiceInputScreen(
                        productProvider: widget.productProvider,
                        aiProvider: widget.aiProvider,
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Next: Add Voice Story'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
