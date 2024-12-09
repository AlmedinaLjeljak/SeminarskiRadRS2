import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xfit_mobile/models/cart.dart';
import 'package:xfit_mobile/models/product.dart';
import 'package:xfit_mobile/screens/cart_screen.dart';
import 'package:collection/collection.dart';

class CartProvider with ChangeNotifier {
  Cart cart = Cart();

  
  addToCart(Product product) {
    if (findInCart(product) != null) {
      findInCart(product)?.count++;
    } else {
      cart.items.add(CartItem(product, 1));
    }
    calculateTotal();
    notifyListeners();
  }

  removeFromCart(Product product) {
    cart.items
        .removeWhere((item) => item.product.proizvodId == product.proizvodId);
    notifyListeners();
  }

  CartItem? findInCart(Product product) {
    CartItem? item = cart.items.firstWhereOrNull((item) => item.product.proizvodId == product.proizvodId);
    return item;
  }

    decreaseQuantity(Product product) {
    final existingItem = findInCart(product);

    if (existingItem != null) {
      existingItem.count--;
      if (existingItem.count == 0) {
        cart.items.remove(existingItem);
      }
    }
    calculateTotal();
    notifyListeners();
  }

  calculateTotal() {
    total = 0;
    for (var item in cart.items) {
      total += item.count * (item.product.cijena ?? 0.0); 

    }
  }
}