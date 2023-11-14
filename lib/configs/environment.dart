import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

// ignore: avoid_classes_with_only_static_members
class Environment {
  // final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  ///This can be either development, staging, production or Unknown
  static String environment = 'Unknown';

  factory Environment() {
    return _instance;
  }

  Environment._privateConstructor();

  static final Environment _instance = Environment._privateConstructor();

  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
  }

  static String fileName(PackageInfo packageInfo) {
    final String packageName = packageInfo.packageName;
    return packageName;
  }

  static String get baseUrl {
    return dotenv.env['BASE_URL'] ?? 'API Url not found!';
  }

  static String get googleMapsAPIkey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
}
