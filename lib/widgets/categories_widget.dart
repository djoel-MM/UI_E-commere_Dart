import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  // Daftar aset gambar kategori (lokal, sementara pakai gambar jam).
  static const List<String> _categoryImages = [
    'images/categories/forerunner-165-aqua-cf-lg.webp',
    'images/categories/fenix-7-pro-sapphire-carbongray-cf-lg.webp',
    'images/categories/forerunner-165-aqua-cf-lg.webp',
    'images/categories/fenix-7-pro-sapphire-carbongray-cf-lg.webp',
  ];

  @override
  Widget build(BuildContext context) {
    // List kategori produk
    final List<String> categories = [
      'Outfit',
      'Makanan',
      'Skincare',
      'Elektronik',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < categories.length; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    _categoryImages[i],
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.category,
                        size: 28,
                        color: Color(0xFF0D9488),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    categories[i],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
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
}
