import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../models/authentication/authenticated_user.dart';

final authLocalSourceProvider =
    Provider<AuthLocalDataSource>((ref) => AuthLocalDataSourceImpl());

abstract class AuthLocalDataSource {
  Future<AuthenticatedUser> saveAuthenticatedUser(AuthenticatedUser authUser);
  Future<bool> clearAuthenticatedUser();
  Future<AuthenticatedUser?> getAuthenticatedUser();
  Stream<AuthenticatedUser?> streamUserStatus();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userKey = 'auth_user';

  @override
  Future<bool> clearAuthenticatedUser() async {
    final box = await Hive.openBox<AuthenticatedUser>(_userKey);

    try {
      box.clear();
      return true;
    } on Exception catch (e) {
      throw Exception(e);
    } finally {}
  }

  @override
  Future<AuthenticatedUser> saveAuthenticatedUser(
      AuthenticatedUser authUser) async {
    final box = await Hive.openBox<AuthenticatedUser>(_userKey);

    try {
      await box.put(_userKey, authUser);
      return authUser;
    } on Exception catch (e) {
      throw Exception(e);
    } finally {}
  }

  @override
  Future<AuthenticatedUser?> getAuthenticatedUser() async {
    final box = await Hive.openBox<AuthenticatedUser>(_userKey);

    try {
      final user = box.get(_userKey);

      if (user != null) {
        return user;
      } else {
        return null;
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<AuthenticatedUser?> streamUserStatus() async* {
    final box = await Hive.openBox<AuthenticatedUser>(_userKey);

    yield await getAuthenticatedUser();

    yield* box.watch(key: _userKey).map((event) {
      return event.value as AuthenticatedUser?;
    }).asBroadcastStream();
  }
}
