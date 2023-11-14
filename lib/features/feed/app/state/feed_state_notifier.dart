import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/features/feed/data/repository/repository.dart';
import 'package:outt/features/feed/models/event.dart';

part 'feed_states.dart';

final feedStateNotifierProvider =
    StateNotifierProvider.autoDispose<FeedStateNotifier, FeedState>((ref) {
  return FeedStateNotifier(ref);
});

class FeedStateNotifier extends StateNotifier<FeedState> {
  final FeedRepository _feedRepository;
  FeedStateNotifier(Ref ref)
      : _feedRepository = ref.read(feedRepositoryProvider),
        super(InitialFeedState()) {
    getEventFeeds();
  }

  Future<void> getEventFeeds() async {
    state = FeedLoading();

    final getFeedOrError = await _feedRepository.getEventFeed();

    state = getFeedOrError.fold(
      (l) => FeedFailure(l),
      (r) => FeedSuccess(r),
    );
  }
}
