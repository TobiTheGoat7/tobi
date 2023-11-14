import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outt/features/auth/app/screens/sign_in_page.dart';

import '../../screen_util_wrapper.dart';

void main() {
  //This test is for the Sign in page widgets.

  group('Sign In Page Tests', () {
    testWidgets('Testing the Sign In page text widgets', (widgetTester) async {
      await widgetTester.pumpWidget(
          MaterialApp(home: wrapWithScreenUtil(const SignInScreen())));

      final facebookTextFinder = find.text("Sign in with Facebook");
      final googleTextFinder = find.text('Sign in with Google');
      final appleTextFinder = find.text('Sign in with Apple');
      final instagramTextFinder = find.text('Sign in with Instagram');
      final snapchatTextFinder = find.text('Sign in with Snapchat');

      expect(facebookTextFinder, findsOneWidget);
      expect(googleTextFinder, findsOneWidget);
      expect(appleTextFinder, findsOneWidget);
      expect(instagramTextFinder, findsOneWidget);
      expect(snapchatTextFinder, findsOneWidget);
    });

    testWidgets(
      'Testing the Sign in page Button Images',
      (widgetTester) async {
        await widgetTester.pumpWidget(wrapWithScreenUtil(const SignInScreen()));

        expect(find.byIcon(Icons.facebook_outlined), findsOneWidget);
        expect(find.byIcon(Icons.snapchat), findsOneWidget);

        expect(find.byType(Image), findsAtLeastNWidgets(3));
      },
    );
  });
}
