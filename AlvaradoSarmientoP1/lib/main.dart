import 'package:flutter/material.dart';
import 'package:flutter_3_riverpod_full/screens/home/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//2.1 DEFINIR EL PROVIDER SCOPE (RIVERPOD)
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const HomeScreen(),
    );
  }
}
