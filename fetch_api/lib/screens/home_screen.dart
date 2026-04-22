import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fetch_api/models/game_model.dart';
import 'package:fetch_api/services/gamer_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _service = GamerServices();
  late final Future<List<GamerPowerModels>> _futureData = _service.readApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Hello world"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<GamerPowerModels>?>(
      future: _futureData,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildGridView(snapshot.data);
        }
        throw Exception("Error: ConnectionState");
      },
    );
  }

  Widget _buildGridView(List<GamerPowerModels>? items) {
    if (items == null) {
      return Center(child: Text("APi Not found..!"));
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1000000000000000 / 1000000000000000,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return Card(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: item.image,
                  errorWidget: (_, _, _) => Container(color: Colors.grey),
                  placeholder: (_, _) => Container(color: Colors.grey),
                ),
              ),

              Padding(
                padding: const EdgeInsetsGeometry.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                child: Text(item.title),
              ),
            ],
          ),
        );
      },
    );
  }
}
