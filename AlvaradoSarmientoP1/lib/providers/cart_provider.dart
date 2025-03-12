import 'package:flutter_3_riverpod_full/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends Notifier<Set<Product>> {
//CartNotifier() : super(<Product>{}); // Inicializa como un Set<Product> vacío
// Tambien inicializa con Set<Product> vacio
  @override
  Set<Product> build() {
    return const {};
  }

  String carFilter = "Todos";
// methods to update state
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

  // Funcion para filtar el carrito eliminando las selecciones
  Set<Product> filterProducts() {
    Set<Product> newState = {};

    if (carFilter == 'Todos') {
      return state;
    } else if (carFilter == 'Menos de 50') {
      for (var p in state) {
        if (p.price < 50) {
          newState.add(p);
        }
      }
      return newState;
    } else {
      for (var p in state) {
        if (p.price > 50) {
          newState.add(p);
        }
      }
      return newState;
    }
  }

  void saveFilterState(String filter) {
    carFilter = filter;
  }

// Método para vaciar el carrito  (Challenge 1)
  void clearCart() {
    state = {};
  }

  // Getter para obtener el total del carrito
  int get cartTotal {
    int total = 0;
    var filteredState = filterProducts();
    for (Product product in filteredState) {
      total += product.price;
    }
    return total;
  }
}

//Declaramos el riverpod de forma manual
//Note que se usa "NotifierProvider" (mutable)
final cartNotifierProvider =
    NotifierProvider<CartNotifier, Set<Product>>(CartNotifier.new);
