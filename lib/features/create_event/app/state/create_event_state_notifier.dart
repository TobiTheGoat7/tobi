import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/features/create_event/data/repository/repository.dart';
import 'package:outt/features/create_event/models/event_details_full_dto.dart';

final createEventStateNotifierProvider =
    StateNotifierProvider<CreateEventStateNotifier, CreateEventState>((ref) {
  return CreateEventStateNotifier(ref);
});

class CreateEventStateNotifier extends StateNotifier<CreateEventState> {
  final CreateEventRepository createEventRepository;
  CreateEventStateNotifier(Ref ref)
      : createEventRepository = ref.read(createEventRepoProvider),
        super(InitialState());

  Future<void> createEventFull(EventFullDetailsDTO eventFullDetailsDTO) async {
    state = CreateEventLoading();

    final createOrError =
        await createEventRepository.createEvent(eventFullDetailsDTO);

    state = createOrError.fold(
        (l) => CreateEventFailure(l), (r) => CreateEventSuccess(r));
  }
}

class CreateEventState {}

class InitialState extends CreateEventState {}

class CreateEventLoading extends CreateEventState {}

class CreateEventSuccess extends CreateEventState {
  final bool status;

  CreateEventSuccess(this.status);
}

class CreateEventFailure extends CreateEventState {
  final Failure failure;

  CreateEventFailure(this.failure);
}
