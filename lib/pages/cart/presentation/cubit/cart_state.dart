import 'package:guruh3/pages/cart/data/models/cart_model.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartSuccess extends CartState {
  final List<CartItemModel> cartItems;

  const CartSuccess({required this.cartItems});
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});
}
