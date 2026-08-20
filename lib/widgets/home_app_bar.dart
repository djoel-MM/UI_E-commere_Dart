import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, this.onCartTap, this.onChatTap});

  final VoidCallback? onCartTap;
  final VoidCallback? onChatTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          // Tombol Menu / Navigation Drawer
          const Icon(
            Icons.sort,
            size: 30,
            color: Color(0xFF0D9488),
          ),
          const SizedBox(width: 20),

          // Judul / Nama Toko
          const Text(
            "DP Shop",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D9488),
            ),
          ),

          const Spacer(),

          // Icon Chat (dengan badge notifikasi)
          InkWell(
            onTap: onChatTap,
            child: Badge(
              label: const Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.red,
              offset: const Offset(-3, -4),
              child: const Icon(
                Icons.chat_bubble_outline,
                size: 30,
                color: Color(0xFF0D9488),
              ),
            ),
          ),
          const SizedBox(width: 15),

          
        ],
      ),
    );
  }
}
