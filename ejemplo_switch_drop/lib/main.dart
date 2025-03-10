import 'package:flutter/material.dart';
import 'package:flutter_drop_down_menu/providers/switch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Always watch the filtered products to get updated data
    var allProducts =
        ref.watch(switchProviderProvider.notifier).filteredProducts();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Ejemplo DropdownButton")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selecciona una opción:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),

              // Dropdown to change filter
              DropdownButton<String>(
                value: ref.watch(switchProviderProvider).selectedValue,
                onChanged: (nuevaOpcion) {
                  if (nuevaOpcion != null) {
                    ref
                        .read(switchProviderProvider.notifier)
                        .setSelectedValue(nuevaOpcion);
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

              // Switch to enable/disable filtering
              Switch(
                value: ref.watch(switchProviderProvider).isSwitch,
                onChanged: (bool valorSwitch) {
                  ref
                      .read(switchProviderProvider.notifier)
                      .setSwitch(valorSwitch);
                  ref.read(switchProviderProvider.notifier).filteredProducts();
                },
              ),

              const SizedBox(height: 40),

              // Display the selected option
              Text(
                ref.watch(switchProviderProvider).isSwitch
                    ? 'Seleccionaste: ${ref.watch(switchProviderProvider).selectedValue}'
                    : ' ',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // Grid View for displaying products
              Expanded(
                child: GridView.builder(
                  itemCount: allProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 20,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.blueGrey.withAlpha((0.05 * 255).toInt()),
                      child: Column(
                        children: [
                          Text(allProducts[index].name),
                          Text('USD ${allProducts[index].price}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
