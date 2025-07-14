class OrderItemModel {
  final int id;
  final int bookId;
  final int quantity;

  const OrderItemModel({
    this.id = -1,
    this.bookId = -1,
    this.quantity = 0,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? -1,
      bookId: json['book_id'] ?? -1,
      quantity: json['quantity'] ?? 0,
    );
  }
}

class OrderModel {
  final int id;
  final int userId;
  final double latitude;
  final double longitude;
  final String datetime;
  final String status;
  final List<OrderItemModel> items;

  const OrderModel({
    this.id = -1,
    this.userId = -1,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.datetime = '',
    this.status = 'pending',
    this.items = const [],
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? -1,
      userId: json['user_id'] ?? -1,
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      datetime: json['datetime'] ?? '',
      status: json['status'] ?? 'pending',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
    );
  }
}
