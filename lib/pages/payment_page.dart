import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _methodIndex = -1;
  bool _processing = false;

  static const List<Map<String, dynamic>> _methods = [
    {'icon': Icons.account_balance, 'name': 'Transfer Bank', 'desc': 'BCA / BNI / Mandiri / BRI'},
    {'icon': Icons.account_balance_wallet, 'name': 'E-Wallet', 'desc': 'GoPay / OVO / DANA / ShopeePay'},
    {'icon': Icons.credit_card, 'name': 'Kartu Kredit/Debit', 'desc': 'Visa / Mastercard / JCB'},
    {'icon': Icons.payments_outlined, 'name': 'COD', 'desc': 'Bayar di tempat saat paket tiba'},
  ];

  Future<void> _pay(Map<String, dynamic> args) async {
    setState(() => _processing = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    final cart = context.read<CartProvider>();
    final orders = context.read<Orders>();
    final subtotal = cart.subtotal;
    final shippingCost = args['shippingCost'] as int;
    final voucher = args['voucher'];
    final discount =
        voucher == null ? 0 : voucher.discountFor(subtotal, shippingCost) as int;

    final order = orders.createOrder(
      items: cart.selectedItems,
      recipient: 'Ade Setiawan',
      phone: '0812-3456-7890',
      address: 'Jl. Merdeka No. 45, Bandung, Jawa Barat 40115',
      courier: args['courier'] as String,
      shippingCost: shippingCost,
      paymentMethod: _methods[_methodIndex]['name'] as String,
      subtotal: subtotal,
      discount: discount,
    );
    cart.clearSelected();
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      '/payment-success',
      arguments: order.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final map = args is Map<String, dynamic> ? args : <String, dynamic>{};

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D9488),
        foregroundColor: Colors.white,
        title: const Text('Pembayaran'),
      ),
      body: _processing ? _buildProcessing() : _buildMethods(map),
    );
  }

  Widget _buildProcessing() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFF0D9488)),
          const SizedBox(height: 20),
          const Text(
            'Memproses pembayaran...',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            'Jangan tutup aplikasi ini',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildMethods(Map<String, dynamic> map) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.receipt_long, color: Color(0xFF0D9488)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Ekspedisi: ${map['courier'] ?? 'Reguler'}',
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Pilih Metode Pembayaran',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        for (int i = 0; i < _methods.length; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: _methodIndex == i
                  ? Border.all(color: const Color(0xFF0D9488), width: 1.5)
                  : null,
            ),
            child: RadioListTile<int>(
              value: i,
              groupValue: _methodIndex,
              activeColor: const Color(0xFF0D9488),
              title: Text(
                _methods[i]['name'] as String,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              subtitle: Text(
                _methods[i]['desc'] as String,
                style: const TextStyle(fontSize: 12),
              ),
              secondary: Icon(
                _methods[i]['icon'] as IconData,
                color: const Color(0xFF0D9488),
              ),
              onChanged: (value) => setState(() => _methodIndex = value!),
            ),
          ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                _methodIndex == -1 ? null : () => _pay(map),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D9488),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Bayar Sekarang',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D9488).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle,
                    size: 64, color: Color(0xFF0D9488)),
              ),
              const SizedBox(height: 24),
              const Text(
                'Pembayaran Berhasil!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Pesanan kamu sedang diproses oleh toko',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F8),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  orderId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F766E),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/orders', (route) => false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D9488),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Lihat Pesanan Saya',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0D9488),
                    side: const BorderSide(color: Color(0xFF0D9488)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Belanja Lagi'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
