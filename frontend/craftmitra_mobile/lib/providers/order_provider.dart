import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/cart_model.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModel> _orders = [];

  OrderProvider() {
    _initSampleOrders();
  }

  void _initSampleOrders() {
    _orders.add(
      OrderModel(
        id: '98421',
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        stage: OrderStage.handcrafted,
        items: [],
        totalAmount: 2450.0,
        artisanContribution: 2107.0,
        deliveryAddress: 'Flat 402, Green Acres, Koramangala, Bengaluru - 560034',
        paymentMethod: 'UPI (Google Pay)',
        trackingSteps: [
          TrackingStep(
            title: 'Order Placed & Confirmed',
            description: 'Order confirmed and sent to Master Artisan Pandit Ramkishan in Molela, Rajasthan.',
            date: '21 Sep 2026, 11:30 AM',
            isCompleted: true,
          ),
          TrackingStep(
            title: 'Handcrafting & Clay Molding',
            description: 'Artisan hand-pinched the Banas river clay and crafted the sun motif relief.',
            date: '22 Sep 2026, 04:15 PM',
            isCompleted: true,
            isCurrent: true,
          ),
          TrackingStep(
            title: 'Kiln Firing & Natural Pigment Dyes',
            description: 'Traditional wood-kiln firing to achieve authentic terracotta ringing tone.',
            date: 'Expected 24 Sep',
            isCompleted: false,
          ),
          TrackingStep(
            title: 'Eco-Protective Packaging & Quality Seal',
            description: 'Verified CraftMitra GI Seal applied; wrapped in natural straw cushioning.',
            date: 'Expected 25 Sep',
            isCompleted: false,
          ),
          TrackingStep(
            title: 'Dispatched via Rural India Post',
            description: 'Surface courier dispatched with direct GPS tracking.',
            date: 'Expected 26 Sep',
            isCompleted: false,
          ),
          TrackingStep(
            title: 'Delivered to Doorstep',
            description: 'Arriving at your home with artisan authenticity card.',
            date: 'Expected 28 Sep',
            isCompleted: false,
          ),
        ],
      ),
    );
  }

  List<OrderModel> get orders => List.unmodifiable(_orders);

  OrderModel? getOrderById(String id) {
    try {
      return _orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return _orders.isNotEmpty ? _orders.first : null;
    }
  }

  OrderModel createOrder({
    required List<CartItemModel> items,
    required double totalAmount,
    required double artisanContribution,
    required String deliveryAddress,
    required String paymentMethod,
  }) {
    final order = OrderModel(
      id: '${(10000 + _orders.length + 1)}',
      orderDate: DateTime.now(),
      stage: OrderStage.placed,
      items: List.from(items),
      totalAmount: totalAmount,
      artisanContribution: artisanContribution,
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      trackingSteps: [
        TrackingStep(
          title: 'Order Placed & Confirmed',
          description: 'Payment verified. Artisan notified immediately via SMS & WhatsApp.',
          date: 'Just now',
          isCompleted: true,
          isCurrent: true,
        ),
        TrackingStep(
          title: 'Craft Preparation at Artisan Workshop',
          description: 'Raw materials selection and artisanal finishing.',
          date: 'Upcoming',
          isCompleted: false,
        ),
        TrackingStep(
          title: 'Quality Verification & CraftMitra Seal',
          description: 'Inspection for authentic handmade standards.',
          date: 'Upcoming',
          isCompleted: false,
        ),
        TrackingStep(
          title: 'Dispatched from Village Cluster',
          description: 'Shipped directly from the maker’s home village.',
          date: 'Upcoming',
          isCompleted: false,
        ),
        TrackingStep(
          title: 'Delivered',
          description: 'Safe arrival at your doorstep.',
          date: 'Estimated 4-6 business days',
          isCompleted: false,
        ),
      ],
    );

    _orders.insert(0, order);
    notifyListeners();
    return order;
  }
}
