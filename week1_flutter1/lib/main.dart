import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: .fromSeed(seedColor: Color(0xfff2f2f2)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffad56c4),
          foregroundColor: Color(0xfff5f5f5),
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: .fromSeed(seedColor: Color(0xffffc2ba),
        brightness: Brightness.dark),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffad56c4),
          foregroundColor: Color(0xfff5f5f5),
        )

      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff8da1),
        foregroundColor: Theme.of(context).colorScheme.onTertiary,
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
