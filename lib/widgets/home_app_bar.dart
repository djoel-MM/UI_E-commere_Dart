import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, this.onCartTap, this.onChatTap});

  final VoidCallback? onCartTap;
  final VoidCallback? onChatTap;

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().selectedQuantity;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.storefront, size: 26, color: Colors.white),
              const SizedBox(width: 8),
              const Text(
                "TealShop",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onChatTap,
                child: const Badge(
                  label: Text('2'),
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              InkWell(
                onTap: onCartTap,
                child: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  backgroundColor: const Color(0xFFF59E0B),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/search'),
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFF0D9488)),
                  const SizedBox(width: 8),
                  Text(
                    'Cari produk, kategori...',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  const Spacer(),
                  const Icon(Icons.camera_alt_outlined,
                      color: Color(0xFF0D9488)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
