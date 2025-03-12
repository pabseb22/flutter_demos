import 'package:flutter/material.dart';
import 'package:flutter_3_riverpod_full/providers/cart_provider.dart';
import 'package:flutter_3_riverpod_full/providers/products_provider.dart';
import 'package:flutter_3_riverpod_full/providers/switch_provider.dart';
import 'package:flutter_3_riverpod_full/shared/cart_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref
        .watch(productsProvider.notifier)
        .filteredProducts(); // Leyendo el provider de productos

    final cartProducts = ref.watch(cartNotifierProvider);

    var displayCount = ref.watch(switchNotifierProvider); // PAra ocultar todo

    return Scaffold(
      appBar: AppBar(title: const Text('Productos en Venta'), actions: [
        Switch(
            // This bool value toggles the switch.
            value: ref.watch(switchNotifierProvider),
            activeColor: Colors.blue,
            onChanged: (bool value) {
              ref.read(switchNotifierProvider.notifier).updateSwitch(value);
            }),
        CartIcon()
      ]),
      body: Center(
        child: Column(
          children: displayCount
              ? [
                  Text(
                    'Examen Parcial 1 Pablo Alvarado:',
                    style: TextStyle(fontSize: 20, color: Colors.redAccent),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Selecciona una Opción:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  const SizedBox(height: 10),

                  // Dropdown to change filter
                  DropdownButton<String>(
                    value: ref.watch(productsProvider).selectedValue,
                    onChanged: (nuevaOpcion) {
                      if (nuevaOpcion != null) {
                        ref
                            .read(productsProvider.notifier)
                            .setSelectedValue(nuevaOpcion);
                        ref
                            .read(cartNotifierProvider.notifier)
                            .saveFilterState(nuevaOpcion);
                      }
                    },
                    items: const [
                      DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                      DropdownMenuItem(
                          value: 'Menos de 50', child: Text('Menos de 50 USD')),
                      DropdownMenuItem(
                          value: 'Más de 50', child: Text('Más de 50 USD')),
                    ],
                  ),

                  const SizedBox(height: 40),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: GridView.builder(
                        itemCount: allProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            color:
                                Colors.blueGrey.withAlpha((0.05 * 255).toInt()),
                            child: Column(
                              children: [
                                Image.asset(allProducts[index].image,
                                    width: 60, height: 60),
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
                  ),
                ]
              : [],
        ),
      ),
    );
  }
}
