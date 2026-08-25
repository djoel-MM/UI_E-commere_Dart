import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => Map.unmodifiable(_items);

  List<CartItem> get itemList => _items.values.toList();

  List<CartItem> get selectedItems =>
      _items.values.where((i) => i.selected).toList();

  int get itemCount => _items.length;

  int get selectedQuantity =>
      _items.values
          .where((i) => i.selected)
          .fold(0, (sum, i) => sum + i.quantity);

  int get subtotal =>
      _items.values
          .where((i) => i.selected)
          .fold(0, (sum, i) => sum + i.totalPrice);

  bool isInCart(String productId) => _items.containsKey(productId);

  int quantityOf(String productId) => _items[productId]?.quantity ?? 0;

  void add(Product product, {int quantity = 1}) {
    if (_items.containsKey(product.id)) {
      _items[product.id] =
          _items[product.id]!.copyWith(quantity: _items[product.id]!.quantity + quantity);
    } else {
      _items[product.id] = CartItem(product: product, quantity: quantity);
    }
    notifyListeners();
  }

  void increase(String productId) {
    final item = _items[productId];
    if (item == null) return;
    _items[productId] = item.copyWith(quantity: item.quantity + 1);
    notifyListeners();
  }

  void decrease(String productId) {
    final item = _items[productId];
    if (item == null) return;
    if (item.quantity <= 1) {
      _items.remove(productId);
    } else {
      _items[productId] = item.copyWith(quantity: item.quantity - 1);
    }
    notifyListeners();
  }

  void remove(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void toggleSelected(String productId) {
    final item = _items[productId];
    if (item == null) return;
    _items[productId] = item.copyWith(selected: !item.selected);
    notifyListeners();
  }

  void selectAll(bool value) {
    _items.updateAll((_, item) => item.copyWith(selected: value));
    notifyListeners();
  }

  void clearSelected() {
    _items.removeWhere((_, item) => item.selected);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
