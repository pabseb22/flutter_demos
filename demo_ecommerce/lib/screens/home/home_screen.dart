import 'package:flutter/material.dart';
import 'package:flutter_3_riverpod_full/providers/cart_provider.dart';
import 'package:flutter_3_riverpod_full/providers/products_provider.dart';
import 'package:flutter_3_riverpod_full/providers/switch_provider.dart';
import 'package:flutter_3_riverpod_full/shared/cart_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';

//2.2 Definir Consumer Widgets
class HomeScreen extends ConsumerWidget {
  //Agrear ConsumerWidget
  const HomeScreen({super.key});

  @override
  //2.2 Definiri Consumer Widgets
  Widget build(BuildContext context, WidgetRef ref) {
    //2.3 Utilización de Métodos de Riverpod cualquiera dentro del HomScreen
    final allProducts = ref.watch(productsProvider);

    //5.
    final cartProducts = ref.watch(cartNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos en Venta'),
        actions: [
          Switch(
              // This bool value toggles the switch.
              value: ref.watch(switchNotifierProvider),
              activeColor: Colors.blue,
              onChanged: (bool value) {
                ref.read(switchNotifierProvider.notifier).updateSwitch(value);
              }),
          CartIcon()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProducts
              .length, // utilizar la cantidad de productos de todos los productos
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(5),
              color: Colors.blueGrey.withAlpha((0.05 * 255).toInt()),
              // -----2.4 Mostramos cada uno de los ítems de productos con la ayuda de un fcol
              child: Column(
                children: [
                  Image.asset(allProducts[index].image, width: 60, height: 60),
                  Text(allProducts[index].title),
                  Text('USD ${allProducts[index].price}'),
                  if (cartProducts.contains(allProducts[index]))
                    TextButton(
                      onPressed: () {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .removeProduct(allProducts[index]);
                      },
                      child: const Text('Eliminar'),
                    ),
                  if (!cartProducts.contains(allProducts[index]))
                    TextButton(
                      onPressed: () {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .addProduct(allProducts[index]);
                      },
                      child: const Text('Agregar al carro'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
