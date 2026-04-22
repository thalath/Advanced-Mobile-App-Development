import 'package:cached_network_image/cached_network_image.dart';
import '../models/product_model.dart';
import '../services/product_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color primaryColor = Color(int.parse("0xFF0033FF"));
  Color secondaryColor = Color(int.parse("0xFF6891FF"));

  final _services = ProductServices();
  final _scroller = ScrollController();

  bool showIcon = false;

  late Future<List<ProductModel>?> _futureData = _services.readProductApi();

  @override
  void initState() {
    super.initState();
    _futureData;
    _scroller.addListener(() {
      if (_scroller.position.pixels < 400) {
        setState(() {
          showIcon = false;
        });
      } else {
        setState(() {
          showIcon = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationbar(),
      floatingActionButton: showIcon ? _builFloatActionBar() : null,
    );
  }

  // Appbar Block
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Fetch API",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      leading: Icon(Icons.not_accessible),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _futureData = _services.readProductApi();
        });
      },
      child: FutureBuilder<List<ProductModel>?>(
        future: _futureData,
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
      ),
    );
  }

  Widget _builFloatActionBar() {
    return FloatingActionButton(
      onPressed: () {
        _scroller.animateTo(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Icon(Icons.arrow_upward),
    );
  }

  // bottomNavigation Block
  Widget _buildBottomNavigationbar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }

  // Each Card Block
  Widget _buildGridView(List<ProductModel>? items) {
    if (items == null) {
      return Center(child: Text("Hello world"));
    }
    return GridView.builder(
      controller: _scroller,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return Card(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(8.0),
                child: Text(item.title),
              ),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: item.image,
                  errorWidget: (_, _, _) => Container(color: Colors.grey),
                  placeholder: (_, _) => Container(color: Colors.grey),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("\$${item.price.toStringAsFixed(2)}"),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildRowView(List<ProductModel>? items) {
  if (items == null) {
    return Center(child: Text("Hello world"));
  }
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemBuilder: (BuildContext context, int index) {
      final item = items[index];
      return Row(
        children: [
          Card(
            child: Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: item.image,
                    errorWidget: (_, _, _) => Container(color: Colors.grey),
                    placeholder: (_, _) => Container(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(8.0),
                  child: Text(item.title),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
