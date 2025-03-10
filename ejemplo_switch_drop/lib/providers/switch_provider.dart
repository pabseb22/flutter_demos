import 'package:flutter_drop_down_menu/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'switch_provider.g.dart';

const List<Product> allProducts = [
  Product(id: 1, name: 'Shorts con Estilo', price: 12),
  Product(id: 2, name: 'Kit de karate', price: 34),
  Product(id: 3, name: 'Jeans de Mezclilla', price: 54),
  Product(id: 4, name: 'Mochila Roja', price: 14),
  Product(id: 5, name: 'Tambor y Baquetas', price: 2),
  Product(id: 6, name: 'Maleta Azul', price: 44),
  Product(id: 7, name: 'Patines de Ruedas', price: 52),
  Product(id: 8, name: 'Guitarra Eléctrica', price: 79),
];

//clase de Provider Notifier
@riverpod
class SwitchProvider extends _$SwitchProvider {
  //constructor
  @override
  SwitchDropdownState build() {
    return SwitchDropdownState(
        selectedValue: 'Todos', isSwitch: false); // Estado inicial
  }

  //Método para actualizar el switch
  void setSwitch(bool newValue) {
    state = SwitchDropdownState(
        selectedValue: state.selectedValue, isSwitch: newValue);
    // filteredProducts();
  }

  //Método para actualizar `selectedValue`
  void setSelectedValue(String newValue) {
    state =
        SwitchDropdownState(selectedValue: newValue, isSwitch: state.isSwitch);
  }

  //Método para devolver productos
  List<Product> getAllProducts() {
    return allProducts;
  }

  List<Product> filteredProducts() {
    if (state.selectedValue == 'Todos') {
      return allProducts;
    } else if (state.selectedValue == 'Menos de 50') {
      return allProducts.where((p) => p.price < 50).toList();
    } else {
      return allProducts.where((p) => p.price > 50).toList();
    }
  }
}

//Clase para manejar múltiples estados (del swtich y DropdownButton)
class SwitchDropdownState {
  final String selectedValue;
  final bool isSwitch;
  SwitchDropdownState({required this.selectedValue, required this.isSwitch});
}
