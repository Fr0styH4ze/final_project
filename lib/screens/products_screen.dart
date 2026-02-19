import 'package:final_project/extensions/nav.dart';
import 'package:final_project/models/product.dart';
import 'package:final_project/screens/product_details_screen.dart';
import 'package:final_project/services/api.dart';
import 'package:final_project/widgets/cart_icon_button_widget.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  final String category;

  const ProductsScreen({super.key, required this.category});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ApiService.getProductsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.toUpperCase()),
        actions: const [CartIconButton()],
      ),

      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.thumbnail,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push(ProductDetailScreen(product: product));
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading products"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
