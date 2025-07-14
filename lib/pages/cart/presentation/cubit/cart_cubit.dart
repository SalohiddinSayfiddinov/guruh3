import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/cart/data/repo/cart_repo.dart';
import 'package:guruh3/pages/cart/presentation/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial());

  Future<void> getCart() async {
    emit(const CartLoading());
    try {
      final result = await CartRepo().getCart();
      emit(CartSuccess(cartItems: result));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
