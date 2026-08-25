enum OrderStatus { pending, paid, shipped, completed, cancelled }

class OrderItem {
  final String productId;
  final String name;
  final String image;
  final int price;
  final int quantity;

  const OrderItem({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  int get totalPrice => price * quantity;
}

class Order {
  final String id;
  final List<OrderItem> items;
  final String recipient;
  final String phone;
  final String address;
  final String courier;
  final int shippingCost;
  final String paymentMethod;
  final int subtotal;
  final int discount;
  final int total;
  final DateTime createdAt;
  OrderStatus status;

  Order({
    required this.id,
    required this.items,
    required this.recipient,
    required this.phone,
    required this.address,
    required this.courier,
    required this.shippingCost,
    required this.paymentMethod,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.createdAt,
    this.status = OrderStatus.pending,
  });

  String get statusLabel {
    switch (status) {
      case OrderStatus.pending:
        return 'Belum Bayar';
      case OrderStatus.paid:
        return 'Diproses';
      case OrderStatus.shipped:
        return 'Dikirim';
      case OrderStatus.completed:
        return 'Selesai';
      case OrderStatus.cancelled:
        return 'Dibatalkan';
    }
  }

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);
}
