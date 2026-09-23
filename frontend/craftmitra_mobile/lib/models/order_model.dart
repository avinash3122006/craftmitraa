import 'cart_model.dart';

enum OrderStage {
  placed,
  handcrafted,
  qualityCheck,
  inTransit,
  delivered
}

class TrackingStep {
  final String title;
  final String description;
  final String date;
  final bool isCompleted;
  final bool isCurrent;

  TrackingStep({
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
    this.isCurrent = false,
  });
}

class OrderModel {
  final String id;
  final DateTime orderDate;
  final OrderStage stage;
  final List<CartItemModel> items;
  final double totalAmount;
  final double artisanContribution;
  final String deliveryAddress;
  final String paymentMethod;
  final List<TrackingStep> trackingSteps;

  OrderModel({
    required this.id,
    required this.orderDate,
    required this.stage,
    required this.items,
    required this.totalAmount,
    required this.artisanContribution,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.trackingSteps,
  });

  String get formattedOrderId => '#CM-$id';
}
