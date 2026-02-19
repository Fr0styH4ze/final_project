import 'package:final_project/models/cart_item.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/services/cart.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<CartItem>> cartFuture;

  @override
  void initState() {
    super.initState();
    cartFuture = CartService().getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
        ),
      ),

      body: FutureBuilder<List<CartItem>>(
        future: cartFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!;

          if (items.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                leading: Image.network(item.thumbnail),
                title: Text(item.title),
                subtitle: Text("\$${item.price} x ${item.quantity}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await CartService().removeItem(item.id);
                    setState(() {
                      cartFuture = CartService().getCartItems();
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
