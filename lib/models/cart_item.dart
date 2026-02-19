class CartItem {
  final String id;
  final int productId;
  final String title;
  final double price;
  final String thumbnail;
  final int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['product_id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      quantity: json['quantity'],
    );
  }
}