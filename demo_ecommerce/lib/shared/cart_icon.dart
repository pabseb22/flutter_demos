import 'package:flutter/material.dart';
import 'package:flutter_3_riverpod_full/providers/cart_provider.dart';
import 'package:flutter_3_riverpod_full/providers/switch_provider.dart';
import 'package:flutter_3_riverpod_full/screens/cart/cart_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numeroItems = ref.watch(cartNotifierProvider).length;
    var displayCount = ref.watch(switchNotifierProvider);
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CartScreen();
            }));
          },
          icon: const Icon(Icons.shopping_bag_outlined),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueAccent,
            ),
            child: displayCount
                ? Text(
                    numeroItems.toString(),
                    style: const TextStyle(color: Colors.white),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
