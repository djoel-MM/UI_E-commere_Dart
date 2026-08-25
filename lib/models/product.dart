class Product {
  final String id;
  final String name;
  final String category;
  final int price;
  final int? originalPrice;
  final double rating;
  final int sold;
  final int stock;
  final String image;
  final String description;
  final bool isFlashSale;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    this.rating = 4.5,
    this.sold = 0,
    this.stock = 50,
    required this.image,
    this.description = '',
    this.isFlashSale = false,
  });

  int get discountPercent {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }

  Product copyWith({
    String? id,
    String? name,
    String? category,
    int? price,
    int? originalPrice,
    double? rating,
    int? sold,
    int? stock,
    String? image,
    String? description,
    bool? isFlashSale,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      rating: rating ?? this.rating,
      sold: sold ?? this.sold,
      stock: stock ?? this.stock,
      image: image ?? this.image,
      description: description ?? this.description,
      isFlashSale: isFlashSale ?? this.isFlashSale,
    );
  }
}
