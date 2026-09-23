import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel? product;

  const EditProductScreen({super.key, this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _titleController = TextEditingController(text: p?.name ?? 'Molela Terracotta Plaque');
    _priceController = TextEditingController(text: p?.price.toStringAsFixed(0) ?? '2450');
    _stockController = TextEditingController(text: p?.stockQuantity.toString() ?? '5');
    _descController = TextEditingController(text: p?.description ?? 'Handcrafted using traditional clay...');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Edit Craft Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.paddingPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Craft Title', style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Craft Name'),
              ),
              const SizedBox(height: AppDimensions.spaceMd),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price (₹)', style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: '₹2450'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spaceMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Stock Units', style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _stockController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: '5'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceMd),

              Text('Description & Technique', style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              TextField(
                controller: _descController,
                maxLines: 4,
                decoration: const InputDecoration(hintText: 'Describe materials, dimensions, and craft technique'),
              ),
              const SizedBox(height: AppDimensions.spaceXl),

              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.forestGreen,
                      content: Text('Craft listing updated successfully!'),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
