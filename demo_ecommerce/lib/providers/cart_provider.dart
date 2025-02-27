import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_3_riverpod_full/models/product.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
//Cualquier producto
  @override
  Set<Product> build() {
    return {};
  }

  //6.1
  void addProduct(Product product) {
    if (!state.contains(product)) {
      Set<Product> newState = {}; // Crear un nuevo conjunto vacío
      for (var p in state) {
        newState.add(p); // Agregar todos los productos actuales
      }
      newState.add(product); // Agregar el nuevo producto
      state = newState; // Asignar el nuevo conjunto al estado
    }
  }

  //6.2

  void removeProduct(Product product) {
    if (state.contains(product)) {
      Set<Product> newState = {};
      for (var p in state) {
        if (p.id != product.id) {
          newState.add(p);
        }
      }
      state = newState;
    }
  }

  //Additional, remove all items

  void removeAll() {
    state = {};
  }
}

@riverpod
int cartTotal(ref) {
  final cartProducts = ref.watch(cartNotifierProvider);
  int total = 0;
  for (Product product in cartProducts) {
    total += product.price;
  }
  return total;
}

// //Notifier Provider from Riverpod
// final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
//   return CartNotifier();
// });
