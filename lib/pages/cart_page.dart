
import 'package:flutter/material.dart';
import '../models/product.dart';

class CartPage extends StatelessWidget {
  final List<Product> cart;

  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Page"),
      ),
      body: cart.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                var product = cart[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),
                );
              },
            ),
    );
  }
}
