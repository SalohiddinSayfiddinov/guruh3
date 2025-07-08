import 'package:guruh3/pages/cart/data/models/book_model.dart';

class CartItemModel {
  final BookModel book;
  final int quantity;

  const CartItemModel({
    required this.book,
    this.quantity = 1,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      book: BookModel.fromJson(json['book'] ?? {}),
      quantity: json['quantity'] ?? 1,
    );
  }
}
