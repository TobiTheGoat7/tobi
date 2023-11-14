import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/data/sources/local_source.dart';
import '../../models/authentication/authenticated_user.dart';

final authProvider =
    Provider.autoDispose<AuthManager?>((ref) => AuthManager.instance);

final streamUserProvider =
    StreamProvider.autoDispose<AuthenticatedUser?>((ref) async* {
  yield* AuthManager.instance.streamActiveUser();
});

class AuthManager {
  static final AuthManager instance = AuthManager._();
  final AuthLocalDataSourceImpl _localSource = AuthLocalDataSourceImpl();

  AuthenticatedUser? user;

  AuthManager._() {
    init();
  }

  Future<void> init() async {
    user = await _localSource.getAuthenticatedUser();
  }

  Future<AuthenticatedUser?> getAuthenticatedUser() async {
    return user = await _localSource.getAuthenticatedUser();
  }

  Future<void> clearAuthenticatedUser() async {
    await _localSource.clearAuthenticatedUser();
  }

  Stream<AuthenticatedUser?> streamActiveUser() async* {
    yield* _localSource
        .streamUserStatus()
        .map((event) => user = event)
        .asBroadcastStream();
  }
}
