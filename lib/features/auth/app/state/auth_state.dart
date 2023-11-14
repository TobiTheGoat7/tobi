part of 'auth_state_notifier.dart';

class AuthState {}

class InitialAuthState extends AuthState {}

class SignInLoading extends AuthState {}

class SignInFailure extends AuthState {
  final Failure failure;

  SignInFailure(this.failure);
}

class SignInSuccess extends AuthState {
  final AuthenticatedUser user;

  SignInSuccess(this.user);
}

class SignOutLoading extends AuthState {}

class SignOutFailure extends AuthState {
  final Failure failure;

  SignOutFailure(this.failure);
}

class SignOutSuccess extends AuthState {
  final bool status;

  SignOutSuccess(this.status);
}
