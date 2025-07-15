abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final String data;

  const ProfileLoaded(this.data);
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});
}
