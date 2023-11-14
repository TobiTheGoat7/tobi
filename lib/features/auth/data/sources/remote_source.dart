import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:outt/core/api/api_endpoints.dart';
import 'package:outt/core/network_request/network_request.dart';
import 'package:outt/core/network_retry/network_retry.dart';
import 'package:outt/core/runner/response_processor.dart';
import 'package:outt/models/authentication/authenticated_user.dart';

final authRemoteProvider =
    Provider<AuthRemoteSource>((ref) => AuthRemoteSourceI(
          networkRequest: ref.read(networkRequestProvider),
          networkRetry: ref.read(networkRetryProvider),
        ));

abstract class AuthRemoteSource {
  Future<AuthenticatedUser> signInWithGoogle(SignInProvider provider);
  Future<AuthenticatedUser> signInWithFacebook(SignInProvider provider);
  Future<AuthenticatedUser> signInWithApple();
  Future<AuthenticatedUser> signInWithTwitter();
  Future<bool> signOutGoogle();
  Future<bool> signOutFacebook();
  Future<bool> signOutApple();
  Future<bool> signOutTwitter();

  //
  Future<AuthenticatedUser> pushSignedInUserToOutt(AuthenticatedUser user);
  Future<bool> signOutofOutt();
}

class AuthRemoteSourceI implements AuthRemoteSource {
  final NetworkRequest networkRequest;
  final NetworkRetry networkRetry;

  AuthRemoteSourceI({
    required this.networkRequest,
    required this.networkRetry,
  });

  @override
  Future<AuthenticatedUser> pushSignedInUserToOutt(
      AuthenticatedUser user) async {
    String url = Endpoint.authenticateEndpoint;

    log('pushing user to outt app db');

    final body = {
      // "name": user.name,
      "email": user.email,
      // "phone_number": user.phone ?? " ",
      // "profile_picture": user.photoUrl,
      "provider": user.signInProvider.name
    };

    log(body.toString());

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      ),
    );

    return processResponse<AuthenticatedUser>(
      response: response,
      serializer: (data) {
        log(data.toString());
        final accessToken = data["data"]["access"] as String;
        final userInfo = data["data"]["user_info"] as Map<String, dynamic>;
        final uuid = userInfo["uuid"] as String;
        final userName = userInfo["name"] as String;
        final isNewUser = data["data"]["is_new_user"] as bool;

        return user.copyWith(
          token: accessToken,
          userId: uuid,
          name: userName,
          isNewUser: isNewUser,
        );
      },
    );
  }

  @override
  Future<AuthenticatedUser> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<AuthenticatedUser> signInWithFacebook(SignInProvider provider) async {
    // Create an instance of FacebookLogin
    final fb = FacebookLogin();

    debugPrint('facebook signin in progress');

// Log in
    final res = Platform.isAndroid
        ? await fb.expressLogin()
        : await fb.logIn(permissions: [
            FacebookPermission.publicProfile,
            FacebookPermission.email,
          ]);

    debugPrint('received response');

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken!;
        debugPrint('Access token: ${accessToken.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        debugPrint('Hello, ${profile?.name ?? ''}! You ID: ${profile?.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        debugPrint('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) debugPrint('And your email is $email');

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        debugPrint('Error while log in: ${res.error}');
        break;
    }
    return AuthenticatedUser(
      email: await fb.getUserEmail() ?? '',
      signInProvider: provider,
    );
  }

  @override
  Future<AuthenticatedUser> signInWithGoogle(SignInProvider provider) async {
    print('sign in with google ran');
    GoogleSignInAccount? signInAccount;
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );

    try {
      signInAccount = await googleSignIn.signIn();

      if (signInAccount != null) {
        return AuthenticatedUser(
          email: signInAccount.email,
          signInProvider: provider,
          name: signInAccount.displayName,
          photoUrl: signInAccount.photoUrl,
        );
      } else {
        throw Exception('Sign in with Google unsuccessful');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<AuthenticatedUser> signInWithTwitter() {
    // TODO: implement signInWithTwitter
    throw UnimplementedError();
  }

  @override
  Future<bool> signOutApple() {
    // TODO: implement signOutApple
    throw UnimplementedError();
  }

  @override
  Future<bool> signOutFacebook() {
    // TODO: implement signOutFacebook
    throw UnimplementedError();
  }

  @override
  Future<bool> signOutGoogle() {
    // TODO: implement signOutGoogle
    throw UnimplementedError();
  }

  @override
  Future<bool> signOutTwitter() {
    // TODO: implement signOutTwitter
    throw UnimplementedError();
  }

  @override
  Future<bool> signOutofOutt() {
    // TODO: implement signOutofOutt
    throw UnimplementedError();
  }
}
