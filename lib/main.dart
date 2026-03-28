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
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }


  Future<String> _readData()
  {
    return Future.delayed(Duration(seconds: 5), (){
      return "Data would stored here!";
    });

  }

  Widget _buildBody()
  {
    return Center(
      child: FutureBuilder<String>(future: _readData(), builder: (content, snapshot){
        if (snapshot.hasError){
          return Text("Error ${snapshot.error.toString()}");
        }
      
        if (snapshot.connectionState == ConnectionState.done)
        {
          return Text(snapshot.data!);
        }
        else
        {
          return CircularProgressIndicator();
        }
      }),
    );
  }
}
