import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static const List<Map<String, dynamic>> _faq = [
    {
      'icon': Icons.local_shipping_outlined,
      'question': 'Bagaimana cara melacak pesanan?',
      'answer': 'Buka halaman Cart lalu pilih pesanan Anda untuk melihat status pengiriman.',
    },
    {
      'icon': Icons.payment_outlined,
      'question': 'Metode pembayaran apa saja yang didukung?',
      'answer': 'Kami mendukung transfer bank, e-wallet, dan COD.',
    },
    {
      'icon': Icons.undo_outlined,
      'question': 'Bagaimana kebijakan pengembalian barang?',
      'answer': 'Barang dapat dikembalikan dalam 7 hari setelah diterima.',
    },
    {
      'icon': Icons.support_agent_outlined,
      'question': 'Cara menghubungi customer service?',
      'answer': 'Gunakan menu Chat untuk berbicara langsung dengan penjual.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: const Color(0xFF0D9488),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _faq.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = _faq[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              leading: Icon(item['icon'] as IconData, color: const Color(0xFF0D9488)),
              title: Text(
                item['question'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                Text(item['answer'] as String),
              ],
            ),
          );
        },
      ),
    );
  }
}
