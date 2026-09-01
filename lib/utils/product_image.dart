import 'package:flutter/material.dart';

/// Widget gambar produk yang mendukung sumber network (URL http/https)
/// maupun asset lokal secara otomatis.
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.fit,
    this.errorIconSize = 32,
  });

  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double errorIconSize;

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      width: width,
      height: height,
      color: const Color(0xFF0D9488).withValues(alpha: 0.08),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        size: errorIconSize,
        color: const Color(0xFF0D9488),
      ),
    );

    if (src.startsWith('http')) {
      return Image.network(
        src,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            width: width,
            height: height,
            color: const Color(0xFF0D9488).withValues(alpha: 0.06),
            alignment: Alignment.center,
            child: const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF0D9488),
              ),
            ),
          );
        },
        errorBuilder: (_, __, ___) => fallback,
      );
    }

    return Image.asset(
      src,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}
