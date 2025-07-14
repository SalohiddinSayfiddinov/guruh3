import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/orders/data/order_repo.dart';
import 'package:guruh3/pages/orders/presentation/cubit/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderInitial());

  Future<void> placeOrder(double lat, double long, String date) async {
    emit(const OrderLoading());
    try {
      final result = await OrderRepo().placeOrder(lat, long, date);
      emit(OrderSuccess(result));
    } catch (e) {
      emit(OrderError('Failed to place order: $e'));
    }
  }

  Future<void> getOrders() async {
    emit(const OrderLoading());
    try {
      final orders = await OrderRepo().getOrders();
      emit(OrderGetSuccess(orders));
    } catch (e) {
      emit(OrderError('Failed to fetch orders: $e'));
    }
  }
}
