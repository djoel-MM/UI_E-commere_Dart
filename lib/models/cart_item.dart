import 'product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final bool selected;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selected = true,
  });

  int get totalPrice => product.price * quantity;

  CartItem copyWith({int? quantity, bool? selected}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
      selected: selected ?? this.selected,
    );
  }
}
