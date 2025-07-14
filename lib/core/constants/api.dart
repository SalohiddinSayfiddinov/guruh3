class Api {
  Api._();
  static const String baseUrl = 'https://fastapi-books-app.onrender.com';

  // Endpoints
  static const String categories = '/categories';
  static const String vendorCategories = '$baseUrl/vendor-categories';
  static const String vendors = '$baseUrl/vendors';
  static const String getCart = '$baseUrl/cart/';
  static const String postCart = '$baseUrl/cart/add';
  static const String postOrder = '$baseUrl/orders';
}
