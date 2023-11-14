import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:outt/constants/error_strings.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/core/network_info/network_info.dart';
import 'package:outt/core/runner/service.dart';
import 'package:outt/features/feed/data/sources/feed_remote_source.dart';
import 'package:outt/features/feed/models/event.dart';

final feedRepositoryProvider =
    Provider<FeedRepository>((ref) => FeedRepositoryI(ref));

abstract class FeedRepository {
  Future<Either<Failure, List<EventFeedData>>> getEventFeed();
}

class FeedRepositoryI implements FeedRepository {
  final FeedRemoteSource _feedRemoteSource;
  final NetworkInfo _networkInfo;

  FeedRepositoryI(Ref ref)
      : _feedRemoteSource = ref.read(feedRemoteSourceProvider),
        _networkInfo = ref.read(networkInfoProvider);

  @override
  Future<Either<Failure, List<EventFeedData>>> getEventFeed() {
    ServiceRunner<Failure, List<EventFeedData>> sR =
        ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: _feedRemoteSource.getEvents(),
        errorTitle: ErrorStrings.FEED_ERROR);
  }
}
