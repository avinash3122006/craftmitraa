import 'package:flutter/material.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import 'payment.dart';

class CheckoutScreen extends StatefulWidget {
  final CartProvider cartProvider;
  final OrderProvider? orderProvider;

  const CheckoutScreen({
    super.key,
    required this.cartProvider,
    this.orderProvider,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedAddressIndex = 0;

  final List<Map<String, String>> _addresses = [
    {
      'title': 'Home',
      'name': 'Aarav Sharma',
      'address': 'Flat 402, Green Acres, 5th Cross, Koramangala',
      'city': 'Bengaluru, Karnataka - 560034',
      'phone': '+91 98765 43210',
    },
    {
      'title': 'Office',
      'name': 'Aarav Sharma',
      'address': 'EcoWorld Tech Park, 4th Floor, Bellandur',
      'city': 'Bengaluru, Karnataka - 560103',
      'phone': '+91 98765 43210',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Shipping & Delivery'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: AppDimensions.paddingPage,
                children: [
                  Text(
                    'Select Delivery Address',
                    style: AppTypography.headlineSm.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: AppDimensions.spaceSm),

                  ...List.generate(_addresses.length, (index) {
                    final addr = _addresses[index];
                    final isSelected = _selectedAddressIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedAddressIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: AppDimensions.spaceSm + 4),
                        padding: const EdgeInsets.all(AppDimensions.spaceMd),
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: AppDimensions.roundedLg,
                          border: Border.all(
                            color: isSelected ? AppColors.terracotta : AppColors.surfaceContainerHigh,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: const [AppColors.pressedShadow],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Radio<int>(
                              value: index,
                              groupValue: _selectedAddressIndex,
                              onChanged: (val) => setState(() => _selectedAddressIndex = val!),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        addr['title']!,
                                        style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('• ${addr['name']!}', style: AppTypography.bodySm),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(addr['address']!, style: AppTypography.bodySm),
                                  Text(addr['city']!, style: AppTypography.bodySm),
                                  const SizedBox(height: 4),
                                  Text(addr['phone']!, style: AppTypography.bodySm.copyWith(color: AppColors.outline)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: AppDimensions.spaceSm),

                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_location_alt_outlined, size: 18),
                    label: const Text('Add New Address'),
                  ),
                  const SizedBox(height: AppDimensions.spaceLg),

                  // Eco packaging guarantee
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.spaceMd),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: AppDimensions.roundedLg,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.eco_outlined, color: AppColors.forestGreen, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Packaged directly at the artisan’s rural studio using zero-plastic biodegradable husk padding.',
                            style: AppTypography.bodySm.copyWith(
                              fontSize: 12,
                              color: AppColors.forestGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Proceed to Payment button
            Container(
              padding: const EdgeInsets.all(AppDimensions.margin),
              decoration: const BoxDecoration(
                color: AppColors.pureWhite,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(34, 34, 34, 0.08),
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: () {
                    final selectedAddr = _addresses[_selectedAddressIndex];
                    final fullAddress = '${selectedAddr['address']}, ${selectedAddr['city']}';
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PaymentScreen(
                          cartProvider: widget.cartProvider,
                          orderProvider: widget.orderProvider,
                          deliveryAddress: fullAddress,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Continue to Payment (₹${widget.cartProvider.grandTotal.toStringAsFixed(0)})'),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
