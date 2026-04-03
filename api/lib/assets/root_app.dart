import 'package:flutter/material.dart';
import 'package:api/assets/products.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductApp(),
    );
  }
}