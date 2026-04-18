import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_models.dart';
import 'package:e_commerce/services/product_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Hello world"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [Icon(Icons.notification_add)],
      ),
      body: _buildBody(),
      drawer: _buildDrawer(),
      bottomNavigationBar: _buildButtonNavigationBar(),
    );
  }

  final _service = ProductServices();

  late Future<List<ProductModel>> _futureData = _service.readApi();

  // body block
  Widget _buildBody() {
    return FutureBuilder<List<ProductModel>?>(
      future: _futureData,
      builder: (_, snapshot) {
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

  // Products card block
  Widget _buildGridView(List<ProductModel>? items) {
    if (items == null) {
      return Center(child: Text("API not found"));
    }
    return RefreshIndicator(
      onRefresh: () async { 
        setState(() {
          _futureData = _service.readApi();
        });
       },
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: items.length,
        itemBuilder: (_, index) {
          final item = items[index];
          return Column(
            children: [
              Expanded(
                child: InkWell(
                  child: CachedNetworkImage(
                    imageUrl: item.image,
                    placeholder: (_, _) => Container(color: Colors.grey),
                    errorWidget: (_, _, _) => Container(color: Colors.grey),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // botton navigationbar block
  Widget _buildButtonNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.white),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: Colors.white),
          label: 'Services',
        ),
      ],
      backgroundColor: Colors.amber,
    );
  }

  // drawer block
  Widget _buildDrawer() {
    return SafeArea(
      
      child: Drawer(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Title(
                color: Colors.blueGrey,
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
            ],
          ),
        ),
      ),
    );
  }
}
