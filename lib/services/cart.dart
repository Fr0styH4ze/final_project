import 'package:final_project/models/cart_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartService {
  final supabase = Supabase.instance.client;

  Future<void> addToCart({
    required int productId,
    required String title,
    required double price,
    required String thumbnail,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final existing = await supabase
        .from('carts')
        .select()
        .eq('user_id', user.id)
        .eq('product_id', productId)
        .maybeSingle();

    if (existing != null) {
      await supabase
          .from('carts')
          .update({'quantity': existing['quantity'] + 1})
          .eq('id', existing['id']);
    } else {
      await supabase.from('carts').insert({
        'user_id': user.id,
        'product_id': productId,
        'title': title,
        'price': price,
        'thumbnail': thumbnail,
        'quantity': 1,
      });
    }
  }

  Future<List<CartItem>> getCartItems() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final response = await supabase
        .from('carts')
        .select()
        .eq('user_id', user.id);

    return (response as List).map((item) => CartItem.fromJson(item)).toList();
  }

  Future<void> removeItem(String id) async {
    await supabase.from('carts').delete().eq('id', id);
  }
}
