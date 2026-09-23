import 'package:flutter/material.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import 'order_tracking.dart';

class PaymentScreen extends StatefulWidget {
  final CartProvider cartProvider;
  final OrderProvider? orderProvider;
  final String deliveryAddress;

  const PaymentScreen({
    super.key,
    required this.cartProvider,
    this.orderProvider,
    required this.deliveryAddress,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'title': 'UPI (Instant Direct-to-Artisan)',
      'subtitle': 'Google Pay, PhonePe, Paytm, BHIM',
      'icon': Icons.account_balance_wallet_outlined,
      'badge': 'Fastest & Zero Fee',
    },
    {
      'title': 'Credit / Debit Card',
      'subtitle': 'Visa, Mastercard, RuPay',
      'icon': Icons.credit_card_outlined,
      'badge': null,
    },
    {
      'title': 'Net Banking',
      'subtitle': 'All major Indian banks supported',
      'icon': Icons.account_balance_outlined,
      'badge': null,
    },
    {
      'title': 'Cash on Delivery',
      'subtitle': 'Pay upon safe arrival with artisan authenticity certificate',
      'icon': Icons.payments_outlined,
      'badge': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Payment Options'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: AppDimensions.paddingPage,
                children: [
                  // Amount to pay header
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.spaceMd),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: AppDimensions.roundedLg,
                      boxShadow: const [AppColors.cardShadow],
                      border: Border.all(color: AppColors.surfaceContainerHigh),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Payable',
                              style: AppTypography.bodySm.copyWith(color: AppColors.outline),
                            ),
                            Text(
                              '₹${widget.cartProvider.grandTotal.toStringAsFixed(0)}',
                              style: AppTypography.headlineLg.copyWith(
                                color: AppColors.terracotta,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.tertiaryFixed.withOpacity(0.5),
                            borderRadius: AppDimensions.roundedFull,
                          ),
                          child: Text(
                            '100% Encrypted & Safe',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.tertiary,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceLg),

                  Text(
                    'Choose Payment Mode',
                    style: AppTypography.headlineSm.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: AppDimensions.spaceSm),

                  ...List.generate(_paymentMethods.length, (index) {
                    final method = _paymentMethods[index];
                    final isSelected = _selectedPaymentMethod == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedPaymentMethod = index),
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
                          children: [
                            Radio<int>(
                              value: index,
                              groupValue: _selectedPaymentMethod,
                              onChanged: (val) => setState(() => _selectedPaymentMethod = val!),
                            ),
                            const SizedBox(width: 8),
                            Icon(method['icon'] as IconData, color: AppColors.terracotta, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        method['title'] as String,
                                        style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700),
                                      ),
                                      if (method['badge'] != null) ...[
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.forestGreen.withOpacity(0.12),
                                            borderRadius: AppDimensions.roundedFull,
                                          ),
                                          child: Text(
                                            method['badge'] as String,
                                            style: const TextStyle(
                                              color: AppColors.forestGreen,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    method['subtitle'] as String,
                                    style: AppTypography.bodySm.copyWith(
                                      fontSize: 12,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Pay Now CTA Button
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
                  onPressed: _isProcessing
                      ? null
                      : () async {
                          setState(() => _isProcessing = true);
                          await Future.delayed(const Duration(milliseconds: 1000));

                          final chosenMethod = _paymentMethods[_selectedPaymentMethod]['title'] as String;

                          widget.orderProvider?.createOrder(
                            items: widget.cartProvider.items,
                            totalAmount: widget.cartProvider.grandTotal,
                            artisanContribution: widget.cartProvider.totalArtisanShare,
                            deliveryAddress: widget.deliveryAddress,
                            paymentMethod: chosenMethod,
                          );

                          widget.cartProvider.clearCart();

                          if (!mounted) return;
                          setState(() => _isProcessing = false);

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => OrderTrackingScreen(
                                orderProvider: widget.orderProvider,
                              ),
                            ),
                            (route) => route.isFirst,
                          );
                        },
                  child: _isProcessing
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.pureWhite),
                          ),
                        )
                      : Text('Pay ₹${widget.cartProvider.grandTotal.toStringAsFixed(0)} & Confirm'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
