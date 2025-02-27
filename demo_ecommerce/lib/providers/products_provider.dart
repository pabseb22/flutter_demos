import 'package:flutter_3_riverpod_full/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_provider.g.dart';

const List<Product> allProducts = [
  Product(
      id: '1',
      title: 'Shorts con Estilo',
      price: 12,
      image: 'assets/products/shorts.png'),
  Product(
      id: '2',
      title: 'Kit de karate',
      price: 34,
      image: 'assets/products/karati.png'),
  Product(
      id: '3',
      title: 'Jeans de Mezclilla',
      price: 54,
      image: 'assets/products/jeans.png'),
  Product(
      id: '4',
      title: 'Mochila Roja',
      price: 14,
      image: 'assets/products/backpack.png'),
  Product(
      id: '5',
      title: 'Tambor y Baquetas',
      price: 29,
      image: 'assets/products/drum.png'),
  Product(
      id: '6',
      title: 'Maleta Azul',
      price: 44,
      image: 'assets/products/suitcase.png'),
  Product(
      id: '7',
      title: 'Patines de Ruedas',
      price: 52,
      image: 'assets/products/skates.png'),
  Product(
      id: '8',
      title: 'Guitarra Eléctrica',
      price: 79,
      image: 'assets/products/guitar.png'),
];

@riverpod
List<Product> products(ref) {
  return allProducts;
}

@riverpod
List<Product> reducedProducts(ref) {
  return allProducts.where((p) => p.price < 50).toList();
}

// Al no ser Stet provider vemos como el carrito actualmente es inmutable.

// final productsProvider = Provider<List<Product>>((ref) {
//   return allProducts;
// });

// final reducedProductsProvider = Provider<List<Product>>((ref) {
//   return allProducts.where((p) => p.price < 50).toList();
// });
