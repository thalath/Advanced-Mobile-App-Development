import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_models.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  ProductModel item;
  DetailScreen(this.item);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail")),

      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    ProductModel item = this.widget.item;
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: item.images[0],
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),

        _buildCard(Icons.shopping_bag, item.title),
        _buildCard(Icons.currency_exchange, item.price.toStringAsFixed(2)),
        Card(child: ListTile(title: Text(item.description),)),
        _buildCard(Icons.description, item.category.name),

        FilledButton.icon(onPressed: (){}, label: Text("ADD to Chart"), icon: Icon(Icons.add_chart),)
      ],
    );
  }

  Widget _buildCard(IconData leadingIcon, dynamic item) {
    return Card(
      child: ListTile(
        leading: Icon(leadingIcon),
        title: Text(
          item.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
