import 'package:flutter/foundation.dart';

import '../data/dummy_data.dart';
import '../models/product.dart';

class ProductCatalog extends ChangeNotifier {
  final List<Product> _products = List.from(dummyProducts);

  List<Product> get products => List.unmodifiable(_products);

  List<Product> get flashSaleProducts =>
      _products.where((p) => p.isFlashSale).toList();

  List<String> get categoriesWithStock {
    final set = _products.map((p) => p.category).toSet();
    return ['Semua', ...set];
  }

  Product? byId(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Product> search({
    String query = '',
    String category = 'Semua',
    String sort = 'relevan',
  }) {
    var result = List<Product>.from(_products);
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      result = result
          .where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q))
          .toList();
    }
    if (category != 'Semua') {
      result = result.where((p) => p.category == category).toList();
    }
    switch (sort) {
      case 'termurah':
        result.sort((a, b) => a.price.compareTo(b.price));
      case 'termahal':
        result.sort((a, b) => b.price.compareTo(a.price));
      case 'terlaris':
        result.sort((a, b) => b.sold.compareTo(a.sold));
      case 'rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return result;
  }

  void addProduct(Product product) {
    _products.insert(0, product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final i = _products.indexWhere((p) => p.id == product.id);
    if (i >= 0) {
      _products[i] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
