import 'package:flutter/foundation.dart';

import '../data/dummy_data.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

class Orders extends ChangeNotifier {
  final List<Order> _orders = List.from(dummyOrders);
  int _counter = 102;

  List<Order> get orders => List.unmodifiable(_orders);

  Order? byId(String id) {
    try {
      return _orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Order> byStatus(OrderStatus status) =>
      _orders.where((o) => o.status == status).toList();

  int get pendingCount =>
      _orders.where((o) => o.status == OrderStatus.pending).length;

  Order createOrder({
    required List<CartItem> items,
    required String recipient,
    required String phone,
    required String address,
    required String courier,
    required int shippingCost,
    required String paymentMethod,
    required int subtotal,
    required int discount,
  }) {
    final total = subtotal + shippingCost - discount;
    final order = Order(
      id: 'INV-2026-$_counter',
      items: items
          .map((i) => OrderItem(
                productId: i.product.id,
                name: i.product.name,
                image: i.product.image,
                price: i.product.price,
                quantity: i.quantity,
              ))
          .toList(),
      recipient: recipient,
      phone: phone,
      address: address,
      courier: courier,
      shippingCost: shippingCost,
      paymentMethod: paymentMethod,
      subtotal: subtotal,
      discount: discount,
      total: total < 0 ? 0 : total,
      createdAt: DateTime.now(),
      status: OrderStatus.paid,
    );
    _counter++;
    _orders.insert(0, order);
    notifyListeners();
    return order;
  }

  void advanceStatus(String orderId) {
    final order = byId(orderId);
    if (order == null) return;
    switch (order.status) {
      case OrderStatus.pending:
        order.status = OrderStatus.paid;
      case OrderStatus.paid:
        order.status = OrderStatus.shipped;
      case OrderStatus.shipped:
        order.status = OrderStatus.completed;
      case OrderStatus.completed:
      case OrderStatus.cancelled:
        return;
    }
    notifyListeners();
  }

  void cancelOrder(String orderId) {
    final order = byId(orderId);
    if (order == null) return;
    if (order.status == OrderStatus.pending) {
      order.status = OrderStatus.cancelled;
      notifyListeners();
    }
  }
}
