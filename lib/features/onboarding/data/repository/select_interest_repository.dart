import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:outt/constants/error_strings.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/core/network_info/network_info.dart';
import 'package:outt/core/runner/service.dart';
import 'package:outt/features/onboarding/data/sources/select_interest_local_source.dart';
import 'package:outt/features/onboarding/data/sources/select_interest_remote_source.dart';

final selectInterestRepoProvider =
    Provider<SelectInterestRepository>((ref) => SelectInterestRepositoryI(ref));

abstract class SelectInterestRepository {
  Future<Either<Failure, List<String>>> getAllInterests();
  Future<Either<Failure, List<String>>> getCities();
  Future<Either<Failure, bool>> submitInterestAndCities(
    List<String> cities,
    List<String> interests,
  );
}

class SelectInterestRepositoryI implements SelectInterestRepository {
  final NetworkInfo _networkInfo;
  final SelectInterestLocalSource selectInterestLocalSource;
  final SelectInterestRemoteSource selectInterestRemoteSource;

  SelectInterestRepositoryI(Ref ref)
      : _networkInfo = ref.read(networkInfoProvider),
        selectInterestLocalSource = ref.read(selectInterestLocalSourceProvider),
        selectInterestRemoteSource =
            ref.read(selectInterestRemoteSourceProvider);

  @override
  Future<Either<Failure, List<String>>> getAllInterests() {
    ServiceRunner<Failure, List<String>> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: selectInterestRemoteSource.getAllInterest(),
        errorTitle: ErrorStrings.SELECT_INTEREST_ERROR);
  }

  @override
  Future<Either<Failure, List<String>>> getCities() {
    ServiceRunner<Failure, List<String>> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: selectInterestRemoteSource.getCities(),
        errorTitle: ErrorStrings.SELECT_INTEREST_ERROR);
  }

  @override
  Future<Either<Failure, bool>> submitInterestAndCities(
    List<String> cities,
    List<String> interests,
  ) {
    ServiceRunner<Failure, bool> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: selectInterestRemoteSource.submitInterestsAndCities(
            cities, interests),
        errorTitle: ErrorStrings.SELECT_INTEREST_ERROR);
  }
}
