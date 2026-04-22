import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game API"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.white,
      ),

      body: _buildBody(),
    );
  }

  Future<List<Map<String, dynamic>>?> _readAPI() async {
    http.Response response = await http.get(
      Uri.parse('https://www.gamerpower.com/api/giveaways'),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<Map<String, dynamic>> items = data
          .map((x) => x as Map<String, dynamic>)
          .toList();
      return items;
    }
    throw Exception("Failed API Reading.");
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: _readAPI(),
      builder: (content, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error.toString()}");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return _buildGridView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>>? items) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: items!.length,
      itemBuilder: (cotent, index) {
        final item = items[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: item['image'],
                  placeholder: (_, _) => Container(color: Colors.grey),
                  errorWidget: (_, _, _) => Container(color: Colors.grey),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Text(item['title']),
              Text(item['end_date']),
            ],
          ),
        );
      },
    );
  }
}
