import 'package:flutter/foundation.dart';

class Wishlist extends ChangeNotifier {
  final Set<String> _ids = {};

  Set<String> get ids => Set.unmodifiable(_ids);

  bool contains(String productId) => _ids.contains(productId);

  int get count => _ids.length;

  void toggle(String productId) {
    if (_ids.contains(productId)) {
      _ids.remove(productId);
    } else {
      _ids.add(productId);
    }
    notifyListeners();
  }

  void remove(String productId) {
    _ids.remove(productId);
    notifyListeners();
  }
}
