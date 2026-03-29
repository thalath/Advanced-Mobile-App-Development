import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {

    Color secondary = Color(0xFFF5F5F5);
    Color primary = Color(0xFF0000FF);
    Color backgroundColor = Color(0xFF333333);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Product List", style: TextStyle(fontWeight:FontWeight(600)),),
        centerTitle: true,
        foregroundColor: secondary,
        backgroundColor: primary,
      ),
      body: _buildBody(),
    );
  }

  // Fetch API from Internet https://fakestoreapi.com/products
  Future<List<Map<String, dynamic>>?> _readAPI() async
  {
    http.Response response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200)
    {
      List data = jsonDecode(response.body);
      List<Map<String, dynamic>>? items = data.map((x) => x as Map<String, dynamic>).toList();
      return items;
    }
    return null;
  }


  Widget _buildBody()
  {
    return FutureBuilder(
      future: _readAPI(),
      builder: (content, snapshot)
      {
        if (snapshot.hasError)
        {
          return Text("Error ${snapshot.error.toString()}");
        }

        if (snapshot.connectionState == ConnectionState.done)
        {
          return _buildGridItemsView(snapshot.data);
        }
        else
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  Widget _buildGridItemsView(List<Map<String, dynamic>>? items)
  {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ), 
      itemCount: items!.length,
      itemBuilder: (content, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: item['image'],
                    placeholder: (_, _,) => Container(color: Colors.grey,),
                    errorWidget: (_, _, _,) => Container(color: Colors.grey),
                  )
                ),
                Text(item['title'],),
                SizedBox(height: 8,),
                Text(item['category']),
              ],
            ),
          ),
        );
      }
    );
  }

}