import 'package:final_project/extensions/nav.dart';
import 'package:final_project/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.shopping_cart),
      onPressed: () {
        context.push(const CartScreen(),
        );
      },
    );
  }
}