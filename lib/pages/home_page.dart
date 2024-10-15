
import 'package:flutter/material.dart';
import 'package:store/services/product_services.dart';

import '../models/product.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductService productService = ProductService();
  List<Product> products = [];
  List<Product> cart = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      List<Product> fetchedProducts = await productService.fetchProducts();
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchProductById(int productId) async {
    try {
      Product product = await productService.fetchProductById(productId);
      setState(() {
        cart.add(product);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: cart),
                ),
              );
            },
          )
        ],
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),
                  trailing: ElevatedButton(
                    child: const Text("Add to Cart"),
                    onPressed: () {
                      fetchProductById(product.id);
                    },
                  ),
                );
              },
            ),
    );
  }
}
