import 'package:guruh3/pages/orders/data/models/order_model.dart';

abstract class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderSuccess extends OrderState {
  final String message;

  const OrderSuccess(this.message);
}

class OrderGetSuccess extends OrderState {
  final List<OrderModel> orders;

  const OrderGetSuccess(this.orders);
}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);
}
