import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/home/data/repositories/vendors_repo.dart';
import 'package:guruh3/pages/home/presentation/cubit/vendors/vendors_state.dart';

class VendorsCubit extends Cubit<VendorsState> {
  VendorsCubit() : super(const VendorsInit());

  Future<void> getVendors({String category = ''}) async {
    emit(const VendorsLoading());
    try {
      final vendors = await VendorsRepo().getVendors(category: category);
      emit(VendorsSuccess(vendors));
    } catch (e) {
      emit(VendorsError(e.toString()));
    }
  }
}
