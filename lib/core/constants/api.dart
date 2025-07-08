class Api {
  Api._();
  static const String baseUrl = 'http://127.0.0.1:8000';

  // Endpoints
  static const String categories = '/categories';
  static const String vendorCategories = '$baseUrl/vendor-categories';
  static const String vendors = '$baseUrl/vendors';
  static const String getCart = '$baseUrl/cart/';
  static const String postCart = '$baseUrl/cart/add';
}
