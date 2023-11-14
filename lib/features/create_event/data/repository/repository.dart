import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:outt/constants/error_strings.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/core/network_info/network_info.dart';
import 'package:outt/core/runner/service.dart';
import 'package:outt/features/create_event/data/sources/create_event_remote_source.dart';
import 'package:outt/features/create_event/models/event_details_full_dto.dart';

final createEventRepoProvider = Provider<CreateEventRepository>((ref) {
  return CreateEventRepostoryI(ref);
});

abstract class CreateEventRepository {
  Future<Either<Failure, bool>> createEvent(EventFullDetailsDTO data);
}

class CreateEventRepostoryI implements CreateEventRepository {
  final CreateEventRemoteSource _createEventRemoteSource;
  final NetworkInfo _networkInfo;

  CreateEventRepostoryI(Ref ref)
      : _createEventRemoteSource = ref.read(createEventRemoteProvider),
        _networkInfo = ref.read(networkInfoProvider);

  @override
  Future<Either<Failure, bool>> createEvent(EventFullDetailsDTO data) {
    ServiceRunner<Failure, bool> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: _createEventRemoteSource.createEvent(data),
        errorTitle: ErrorStrings.CREATE_EVENT_ERROR);
  }
}
