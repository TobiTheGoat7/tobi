import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectInterestRemoteSourceProvider = Provider<SelectInterestRemoteSource>(
    (ref) => SelectInterestRemoteSourceI(ref));

abstract class SelectInterestRemoteSource {
  Future<List<String>> getAllInterest();
  Future<List<String>> getCities();

  Future<bool> submitInterestsAndCities(
    List<String> cities,
    List<String> interests,
  );
}

class SelectInterestRemoteSourceI implements SelectInterestRemoteSource {
  SelectInterestRemoteSourceI(Ref ref);

  @override
  Future<List<String>> getAllInterest() {
    // TODO: implement getAllInterests
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getCities() {
    // TODO: implement getCities
    throw UnimplementedError();
  }

  @override
  Future<bool> submitInterestsAndCities(
    List<String> cities,
    List<String> interests,
  ) {
    // TODO: implement submitInterestsAndCities
    throw UnimplementedError();
  }
}
