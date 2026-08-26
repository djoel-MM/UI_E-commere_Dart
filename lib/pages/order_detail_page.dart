import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../providers/order_provider.dart';
import '../utils/format.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final order = context.watch<Orders>().byId(orderId);

    if (order == null) {
      return const Scaffold(
        body: Center(child: Text('Pesanan tidak ditemukan')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D9488),
        foregroundColor: Colors.white,
        title: const Text('Detail Pesanan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _statusCard(context, order),
          const SizedBox(height: 10),
          _addressCard(order),
          const SizedBox(height: 10),
          _itemsCard(order),
          const SizedBox(height: 10),
          _paymentCard(order),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _statusCard(BuildContext context, Order order) {
    final steps = [
      {'icon': Icons.receipt_long, 'label': 'Pesanan dibuat', 'status': OrderStatus.pending},
      {'icon': Icons.payments, 'label': 'Pembayaran diterima', 'status': OrderStatus.paid},
      {'icon': Icons.local_shipping, 'label': 'Sedang dikirim', 'status': OrderStatus.shipped},
      {'icon': Icons.home, 'label': 'Pesanan diterima', 'status': OrderStatus.completed},
    ];

    final activeIndex = order.status == OrderStatus.cancelled
        ? -1
        : steps.indexWhere((s) => s['status'] == order.status);

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, size: 18, color: Colors.teal.shade700),
              const SizedBox(width: 6),
              const Text(
                'Status Pengiriman',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (order.status == OrderStatus.cancelled)
            const Row(
              children: [
                Icon(Icons.cancel, color: Colors.red, size: 22),
                SizedBox(width: 8),
                Text(
                  'Pesanan dibatalkan',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ],
            )
          else
            for (int i = 0; i < steps.length; i++)
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i <= activeIndex
                                ? const Color(0xFF0D9488)
                                : Colors.grey.shade300,
                          ),
                          child: Icon(
                            steps[i]['icon'] as IconData,
                            size: 15,
                            color: i <= activeIndex
                                ? Colors.white
                                : Colors.grey.shade600,
                          ),
                        ),
                        if (i < steps.length - 1)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: i < activeIndex
                                  ? const Color(0xFF0D9488)
                                  : Colors.grey.shade300,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 18),
                      child: Text(
                        steps[i]['label'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: i == activeIndex
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: i <= activeIndex
                              ? Colors.black87
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          if (order.status == OrderStatus.shipped)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.qr_code_2, size: 20, color: Color(0xFFB45309)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'No. Resi: TS20260825001122 • Lacak di halaman kurir',
                      style: TextStyle(fontSize: 12, color: Color(0xFFB45309)),
                    ),
                  ),
                ],
              ),
            ),
          if (order.status == OrderStatus.pending)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      context.read<Orders>().cancelOrder(order.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Batalkan Pesanan'),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _addressCard(Order order) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on, size: 18, color: Color(0xFF0D9488)),
              SizedBox(width: 6),
              Text(
                'Alamat Pengiriman',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${order.recipient} (${order.phone})',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            order.address,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _itemsCard(Order order) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in order.items)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.image,
                      width: 54,
                      height: 54,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 54,
                        height: 54,
                        color:
                            const Color(0xFF0D9488).withValues(alpha: 0.1),
                        child: const Icon(Icons.image,
                            color: Color(0xFF0D9488), size: 22),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(fontSize: 13),
                        ),
                        Text(
                          '${formatRupiah(item.price)} x ${item.quantity}',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatRupiah(item.totalPrice),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D9488),
                    ),
                  ),
                ],
              ),
            ),
          const Divider(),
          Text(
            'Ekspedisi: ${order.courier}',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _paymentCard(Order order) {
    return _card(
      child: Column(
        children: [
          _row('Metode Pembayaran', order.paymentMethod),
          _row('Subtotal', formatRupiah(order.subtotal)),
          _row('Pengiriman', formatRupiah(order.shippingCost)),
          _row(
            'Diskon',
            order.discount > 0 ? '- ${formatRupiah(order.discount)}' : '-',
          ),
          const Divider(),
          _row('Total', formatRupiah(order.total), bold: true),
          const SizedBox(height: 6),
          Text(
            '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              color: bold ? const Color(0xFF0D9488) : null,
            ),
          ),
        ],
      ),
    );
  }
}
