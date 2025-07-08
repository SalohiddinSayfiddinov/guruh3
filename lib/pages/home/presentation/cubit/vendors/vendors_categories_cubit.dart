import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/home/data/repositories/vendors_repo.dart';
import 'package:guruh3/pages/home/presentation/cubit/vendors/vendors_state.dart';

class VendorsCategoriesCubit extends Cubit<VendorsState> {
  VendorsCategoriesCubit() : super(const VendorsInit());

  Future<void> getVendorCategories() async {
    emit(const VendorsLoading());
    try {
      final categories = await VendorsRepo().fetchVendorCategories();
      emit(VendorsCategoriesSuccess(categories));
    } catch (e) {
      emit(VendorsError(e.toString()));
    }
  }
}
