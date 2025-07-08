import 'package:guruh3/pages/home/data/models/category_model.dart';
import 'package:guruh3/pages/home/data/models/vendor_model.dart';

abstract class VendorsState {
  const VendorsState();
}

class VendorsInit extends VendorsState {
  const VendorsInit();
}

class VendorsLoading extends VendorsState {
  const VendorsLoading();
}

class VendorsError extends VendorsState {
  final String message;
  const VendorsError(this.message);
}

class VendorsCategoriesSuccess extends VendorsState {
  final List<CategoryModel> categories;
  const VendorsCategoriesSuccess(this.categories);
}

class VendorsSuccess extends VendorsState {
  final List<VendorModel> vendors;
  const VendorsSuccess(this.vendors);
}
