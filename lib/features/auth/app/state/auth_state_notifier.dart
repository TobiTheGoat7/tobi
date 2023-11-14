import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/features/auth/data/repository/auth_repository.dart';
import 'package:outt/models/authentication/authenticated_user.dart';

part 'auth_state.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(ref),
);

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  AuthStateNotifier(Ref ref)
      : _authRepository = ref.read(authRepositoryProvider),
        super(InitialAuthState());

  Future<void> signIn({
    required SignInProvider provider,
  }) async {
    //Sign in and Sign up are the same.
    state = SignInLoading();

    final signInOrError = await _authRepository.signIn(provider);

    state = signInOrError.fold(
      (l) {
        return SignInFailure(l);
      },
      (user) => SignInSuccess(user),
    );
  }

  Future<void> signOut(AuthenticatedUser user) async {
    state = SignOutLoading();

    final signOutOrError = await _authRepository.signOut();

    state = signOutOrError.fold(
      (l) => SignOutFailure(l),
      (r) => SignOutSuccess(r),
    );
  }
}
