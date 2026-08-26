import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart';
import '../../providers/order_provider.dart';
import '../../utils/format.dart';

class AdminOrdersPage extends StatelessWidget {
  const AdminOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<Orders>().orders;

    if (orders.isEmpty) {
      return Center(
        child: Text(
          'Belum ada pesanan',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: orders.length,
      itemBuilder: (context, i) {
        final order = orders[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      order.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF0F766E),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: _statusColor(order.status)
                          .withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      order.statusLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _statusColor(order.status),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${order.recipient} • ${order.itemCount} produk • ${order.courier} • ${order.paymentMethod}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 4),
              Text(
                order.address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              const Divider(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatRupiah(order.total),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF0D9488),
                    ),
                  ),
                  _actionButton(context, order),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _actionButton(BuildContext context, Order order) {
    switch (order.status) {
      case OrderStatus.pending:
      case OrderStatus.paid:
        return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D9488),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14),
          ),
          onPressed: () => _ship(context, order),
          icon: const Icon(Icons.local_shipping, size: 16),
          label: const Text('Kirim'),
        );
      case OrderStatus.shipped:
        return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F766E),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14),
          ),
          onPressed: () => context.read<Orders>().advanceStatus(order.id),
          icon: const Icon(Icons.check, size: 16),
          label: const Text('Selesaikan'),
        );
      case OrderStatus.completed:
        return const Text(
          'Selesai',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D9488),
          ),
        );
      case OrderStatus.cancelled:
        return const Text(
          'Dibatalkan',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        );
    }
  }

  void _ship(BuildContext context, Order order) {
    final orders = context.read<Orders>();
    if (order.status == OrderStatus.pending) {
      orders.advanceStatus(order.id);
    }
    orders.advanceStatus(order.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${order.id} sedang dikirim'),
        backgroundColor: const Color(0xFF0F766E),
      ),
    );
  }

  Color _statusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.paid:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.indigo;
      case OrderStatus.completed:
        return const Color(0xFF0D9488);
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}
