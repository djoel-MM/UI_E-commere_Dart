import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/dummy_data.dart';
import '../models/voucher.dart';
import '../providers/cart_provider.dart';
import '../utils/format.dart';
import '../utils/product_image.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _courier = 'Reguler';
  int _shippingCost = 15000;
  Voucher? _voucher;

  static const Map<String, int> _couriers = {
    'Hemat': 9000,
    'Reguler': 15000,
    'Instant': 40000,
  };

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.selectedItems;
    final subtotal = cart.subtotal;
    final discount = _voucher?.discountFor(subtotal, _shippingCost) ?? 0;
    final total = subtotal + _shippingCost - discount;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D9488),
        foregroundColor: Colors.white,
        title: const Text('Checkout'),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.25),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        formatRupiah(total < 0 ? 0 : total),
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D9488),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: items.isEmpty
                    ? null
                    : () => Navigator.pushNamed(
                          context,
                          '/payment',
                          arguments: {
                            'courier': _courier,
                            'shippingCost': _shippingCost,
                            'voucher': _voucher,
                          },
                        ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF59E0B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  'Pilih Pembayaran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _addressCard(),
          const SizedBox(height: 10),
          _itemsCard(items),
          const SizedBox(height: 10),
          _courierCard(),
          const SizedBox(height: 10),
          _voucherCard(subtotal),
          const SizedBox(height: 10),
          _summaryCard(subtotal, discount, total),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _addressCard() {
    return _sectionCard(
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
          const SizedBox(height: 10),
          const Row(
            children: [
              Text(
                'Ade Setiawan ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('(0812-3456-7890)', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Jl. Merdeka No. 45, Bandung, Jawa Barat 40115',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Fitur ganti alamat belum tersedia')),
              ),
              child: const Text(
                'Ganti Alamat >',
                style: TextStyle(
                    color: Color(0xFF0D9488), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemsCard(items) {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                     child: ProductImage(
                       src: item.product.image,
                       width: 54,
                       height: 54,
                       fit: BoxFit.cover,
                       errorIconSize: 24,
                     ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'x${item.quantity}',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatRupiah(item.totalPrice),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D9488),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _courierCard() {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.local_shipping, size: 18, color: Color(0xFF0D9488)),
              SizedBox(width: 6),
              Text(
                'Pilih Ekspedisi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final entry in _couriers.entries)
            RadioListTile<String>(
              value: entry.key,
              groupValue: _courier,
              activeColor: const Color(0xFF0D9488),
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                '${entry.key} • Estimasi ${entry.key == 'Instant' ? '3 jam' : entry.key == 'Reguler' ? '2-3 hari' : '4-6 hari'}',
                style: const TextStyle(fontSize: 14),
              ),
              secondary: Text(
                formatRupiah(entry.value),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF0D9488),
                ),
              ),
              onChanged: (value) => setState(() {
                _courier = value!;
                _shippingCost = entry.value;
              }),
            ),
        ],
      ),
    );
  }

  Widget _voucherCard(int subtotal) {
    return _sectionCard(
      child: Row(
        children: [
          const Icon(Icons.confirmation_number_outlined,
              size: 20, color: Color(0xFF0D9488)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Voucher Diskon',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                if (_voucher != null)
                  Text(
                    _voucher!.code,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF0F766E)),
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _showVoucherSheet(subtotal),
            child: Text(
              _voucher == null ? 'Pilih Voucher >' : 'Ganti >',
              style: const TextStyle(
                  color: Color(0xFF0D9488), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showVoucherSheet(int subtotal) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Pilih Voucher',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              for (final voucher in dummyVouchers)
                Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.discount,
                        color: Color(0xFF0D9488)),
                    title: Text(
                      voucher.title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Min. ${formatRupiah(voucher.minSpend)} • ${voucher.code}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: subtotal >= voucher.minSpend
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D9488),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              setState(() => _voucher = voucher);
                              Navigator.pop(sheetContext);
                            },
                            child: const Text('Pakai'),
                          )
                        : const Text(
                            'Belum\nmemenuhi',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                  ),
                ),
              TextButton(
                onPressed: () {
                  setState(() => _voucher = null);
                  Navigator.pop(sheetContext);
                },
                child: const Text('Tanpa voucher'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _summaryCard(int subtotal, int discount, int total) {
    return _sectionCard(
      child: Column(
        children: [
          _summaryRow('Subtotal untuk Produk', formatRupiah(subtotal)),
          _summaryRow('Subtotal Pengiriman', formatRupiah(_shippingCost)),
          _summaryRow(
            'Diskon Voucher',
            discount > 0 ? '- ${formatRupiah(discount)}' : '-',
            valueColor: discount > 0 ? Colors.orange : null,
          ),
          const Divider(),
          _summaryRow(
            'Total Pembayaran',
            formatRupiah(total < 0 ? 0 : total),
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value,
      {bool bold = false, Color? valueColor}) {
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
              color: valueColor ?? (bold ? const Color(0xFF0D9488) : null),
            ),
          ),
        ],
      ),
    );
  }
}
