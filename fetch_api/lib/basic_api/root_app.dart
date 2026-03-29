import 'package:fetch_api/basic_api/product_card.dart';
import 'package:flutter/material.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductCard(),
    );
  }
}