import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, this.selected = 'Semua', this.onTap});

  final String selected;
  final ValueChanged<String>? onTap;

  static const Map<String, IconData> _icons = {
    'Semua': Icons.grid_view_rounded,
    'Elektronik': Icons.devices,
    'Fashion': Icons.checkroom,
    'Makanan': Icons.fastfood,
    'Skincare': Icons.spa,
    'Olahraga': Icons.sports_tennis,
  };

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<ProductCatalog>().categoriesWithStock;

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final isActive = categories[i] == selected;
          return GestureDetector(
            onTap: () => onTap?.call(categories[i]),
            child: Container(
              width: 72,
              margin: const EdgeInsets.only(right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF0D9488)
                          : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      _icons[categories[i]] ?? Icons.category,
                      color:
                          isActive ? Colors.white : const Color(0xFF0D9488),
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    categories[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive
                          ? const Color(0xFF0D9488)
                          : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
