import 'package:flutter/material.dart';
import 'package:flutter_3_riverpod_full/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//3.1 actualizar a consumer el state full
class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool showCoupon = true;

  @override
  Widget build(BuildContext context) {
    final cartProducts = ref.watch(cartNotifierProvider);
    final total = ref.watch(cartTotalProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Carrito'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(cartNotifierProvider.notifier).removeAll();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Column(
              children: [
                Column(
                  children: cartProducts.map((product) {
                    return Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(children: [
                          Image.asset(product.image, width: 60, height: 60),
                          const SizedBox(width: 10),
                          Text('${product.title}...'),
                          const Expanded(child: SizedBox()),
                          Text('USD ${product.price}'),
                        ]));
                  }).toList(), // output cart products here
                ),
                Text('Precio Total USD $total'),
              ], // output cart products here
            ),

            // output totals here
          ],
        ),
      ),
    );
  }
}
