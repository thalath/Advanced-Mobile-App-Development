
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
      home: const MyHomePage(title: 'Product Detail'),
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
      backgroundColor: .fromRGBO(100, 50, 2500, 0.5),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Future<List<Map<String, dynamic>>?> _readAPIS() async
  {
    http.Response response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200)
    {
      List data = jsonDecode(response.body);
      List<Map<String, dynamic>> items = data.map((x) => x as Map<String, dynamic>).toList();
      return items;
    }
    throw Exception("Failed load API");
    
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
      child: FutureBuilder<List<Map<String, dynamic>>?>(future: _readAPIS(), builder: (content, snapshot){
        if (snapshot.hasError){
          return Text("Error ${snapshot.error.toString()}");
        }
      
        if (snapshot.connectionState == ConnectionState.done)
        {
          return _buildGridView(snapshot.data);
        }
        else
        {
          return CircularProgressIndicator();
        }
      }),
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>>? items)
  {
    if (items == null)
    {
      Icon(Icons.hourglass_empty);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:  2,
        childAspectRatio: 2/3,
      ), 
      itemBuilder: (content, index) {
        Map<String, dynamic> item = items![index];

        return Card(
          child: Column(
            children: [
              Expanded(child: CachedNetworkImage(
                imageUrl: item['image'],
                placeholder: (_, _) => Container(color: Colors.grey,),
                errorWidget: (_,_,_) => Container(color: Colors.grey),
              )),
              Text(item['title']),
            ],
          ),
        );
    });
  }
}
