import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:outt/configs/environment.dart';
import 'package:outt/constants/constants.dart';
import 'package:outt/firebase_options.dart';
import 'package:outt/models/authentication/authenticated_user.dart';
import 'package:outt/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outt/services/authmanager/authmanager.dart';
import 'package:outt/services/locationservice/location_manager.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Set orientation as potrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Overriding http to handle bad ssl certificate.
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Initialize Hive.
  await Hive.initFlutter();

  await Environment.initialize();

  Hive
    ..registerAdapter(AuthenticatedUserAdapter())
    ..registerAdapter(SignInProviderAdapter());

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  final user = await AuthManager.instance.getAuthenticatedUser();

  // if (Platform.isAndroid) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  // }

  runApp(
    RestorationScope(
      restorationId: 'outt',
      child: ProviderScope(
          child: MyApp(
        user: user,
      )),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.user});
  final AuthenticatedUser? user;

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    LocationManager locationManager = LocationManager();
    checkForInAppUpdate();
    // locationManager.getCityName();
    return ScreenUtilInit(
        designSize: const Size(
          Constants.designWidth,
          Constants.designHeight,
        ),
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Outt',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.grey,
            ),
            scrollBehavior: const CupertinoScrollBehavior(),
            routerDelegate: appRouter.routerDelegate,
            routeInformationParser: appRouter.routeInformationParser,
            routeInformationProvider: appRouter.routeInformationProvider,
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

checkForInAppUpdate() {
  InAppUpdate.checkForUpdate().then((updateInfo) {
    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      if (updateInfo.immediateUpdateAllowed) {
        // Perform immediate update
        InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
          if (appUpdateResult == AppUpdateResult.success) {
            //App Update successful
          }
        });
      } else if (updateInfo.flexibleUpdateAllowed) {
        //Perform flexible update
        InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
          if (appUpdateResult == AppUpdateResult.success) {
            //App Update successful
            InAppUpdate.completeFlexibleUpdate();
          }
        });
      }
    }
  });
}
