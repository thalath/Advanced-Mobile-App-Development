import '../screens/home_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Color seedColor = Color(0xFFFF8DA1);
    Color seedColor = Colors.red;
    Color primary = seedColor;
    Color secondary = Color(0xFFFFC2BA);
    Color tertiary = Color(0xFFAD56C4);

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: .light,
      theme: ThemeData(
        brightness: .light,
        colorScheme: .fromSeed(
          seedColor: seedColor,
          primary: primary,
          secondary: secondary,
          tertiary: tertiary,
        ),
      ),
      darkTheme: ThemeData(
        brightness: .dark,
        colorScheme: .fromSeed(
          brightness: Brightness.dark,
          seedColor: seedColor,
          primary: primary,
          secondary: secondary,
          tertiary: tertiary,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}