import 'package:final_project/models/product.dart';
import 'package:final_project/services/cart.dart';
import 'package:final_project/widgets/cart_icon_button_widget.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: const [CartIconButton()],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.thumbnail,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const SizedBox(
                  height: 150,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Category: ${product.category}"),
                  const SizedBox(height: 10),
                  Text(
                    "Price: \$${product.price}",
                    style: TextStyle(fontSize: 18, color:Theme.of(context).colorScheme.secondary
),
                  ),
                  const SizedBox(height: 10),
                  Text("Rating: ${product.rating} ⭐"),
                  const SizedBox(height: 15),
                  Text(product.description),
                  SizedBox(height: 15),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await CartService().addToCart(
                          productId: product.id,
                          title: product.title,
                          price: product.price,
                          thumbnail: product.thumbnail,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to cart")),
                        );
                      },
                      child: const Text("Add to Cart"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
