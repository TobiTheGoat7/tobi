import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:outt/constants/error_strings.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/core/network_info/network_info.dart';
import 'package:outt/core/runner/service.dart';
import 'package:outt/features/auth/data/sources/local_source.dart';
import 'package:outt/features/auth/data/sources/remote_source.dart';
import 'package:outt/models/authentication/authenticated_user.dart';

///So the whole Auth process here is that
///we make a request using the appropriate sign in provider platforms
///when the sign in is succssful
///the response is parsed into our own user object
///which is used to create an account for the user on our platform
///while this happens we also sign in the user.
///the sign out will also use the appropriate sign in provider.

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepositoryI(ref));

abstract class AuthRepository {
  Future<Either<Failure, AuthenticatedUser>> signIn(
      SignInProvider signInProvider);
  Future<Either<Failure, bool>> signOut();
}

class AuthRepositoryI implements AuthRepository {
  final NetworkInfo _networkInfo;
  final AuthLocalDataSource _authLocalDataSource;
  final AuthRemoteSource _authRemoteDataSource;

  AuthRepositoryI(Ref ref)
      : _networkInfo = ref.read(networkInfoProvider),
        _authRemoteDataSource = ref.read(authRemoteProvider),
        _authLocalDataSource = ref.read(authLocalSourceProvider);
  @override
  Future<Either<Failure, AuthenticatedUser>> signIn(
      SignInProvider signInProvider) async {
    ServiceRunner<Failure, AuthenticatedUser> sR = ServiceRunner(_networkInfo);

    Future<AuthenticatedUser> call;
    if (await _networkInfo.isConnected) {
      if (signInProvider == SignInProvider.google) {
        call = _authRemoteDataSource.signInWithGoogle(signInProvider);
      } else if (signInProvider == SignInProvider.facebook) {
        call = _authRemoteDataSource.signInWithFacebook(signInProvider);
      } else {
        //Lets default to throw Unimplemented
        call = Future(() => throw UnimplementedError('Unimplemented'));
      }
    } else {
      //Lets default to throw Unimplemented
      call = Future(() => throw UnimplementedError('No Internet Access'));
    }

    return sR.tryRemoteandCatch(
      disableTimeOut: true,
      call: call.then((value) async {
        final user = await _authRemoteDataSource.pushSignedInUserToOutt(value);

        //By not saving authenticated user we  can proceed to Select interest
        //and save the completed user profile then.

        //write this complete user to app database.
        await _authLocalDataSource.saveAuthenticatedUser(user);
        return user;
      }).catchError((error) {
        throw error;
      }),
      errorTitle: ErrorStrings.LOGIN_ERROR,
    );
  }

  @override
  Future<Either<Failure, bool>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
