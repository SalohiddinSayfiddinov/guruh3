import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/profile/data/repo/profile_repo.dart';
import 'package:guruh3/pages/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial());

  void updateProfile({
    String? image,
    double? lat,
    double? long,
  }) async {
    emit(ProfileLoading());
    try {
      final result = await ProfileRepo().updateProfile(
        image: image,
        lat: lat,
        long: long,
      );
      emit(ProfileLoaded(result));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
