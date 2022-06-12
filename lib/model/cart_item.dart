class CartItem {
  final int? id;
  final String? name;
  final String? imageUrl;
  final double? price;
  int? quantity;

  CartItem({this.id, this.name, this.imageUrl, this.price, this.quantity = 1});
}
