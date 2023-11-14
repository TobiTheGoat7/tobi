part of 'feed_state_notifier.dart';

class FeedState {}

class InitialFeedState extends FeedState {}

class FeedLoading extends FeedState {}

class FeedFailure extends FeedState {
  final Failure failure;

  FeedFailure(this.failure);
}

class FeedSuccess extends FeedState {
  final List<EventFeedData> eventFeedData;

  FeedSuccess(this.eventFeedData);
}
