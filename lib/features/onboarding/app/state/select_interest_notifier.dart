import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/features/onboarding/data/repository/select_interest_repository.dart';

part 'select_interest_states.dart';

//when making select interest request
final selectInterestStateProvider =
    StateNotifierProvider<SelectInterestNotifier, SelectInterestStates>(
        (ref) => SelectInterestNotifier(ref));

//WHen making select cities request
final selectCitiesStateProvider = StateNotifierProvider<
    GetSelectInterestCitiesNotifier,
    SelectInterestStates>((ref) => GetSelectInterestCitiesNotifier(ref));

class SelectInterestNotifier extends StateNotifier<SelectInterestStates> {
  final SelectInterestRepository _selectInterestRepository;
  SelectInterestNotifier(Ref ref)
      : _selectInterestRepository = ref.read(selectInterestRepoProvider),
        super(SelectInterestInitialState());

  Future<void> getInterestList() async {
    state = GetListOfInterestLoading();
    final getInterestListOrError =
        await _selectInterestRepository.getAllInterests();

    state = getInterestListOrError.fold(
        (l) => GetListOfInterestFailure(l), (r) => GetListOfInterestSuccess(r));
  }

  Future<void> submitCitiesAndInterests({
    required List<String> cities,
    required List<String> interests,
  }) async {
    state = SubmitInterestsAndCitiesLoading();

    final submitInterestAndCitiesOrError = await _selectInterestRepository
        .submitInterestAndCities(cities, interests);

    state = submitInterestAndCitiesOrError.fold(
        (l) => SubmitInterestsAndCitiesFailure(l),
        (r) => SubmitInterestAndCitiesSuccess(r));
  }
}

class GetSelectInterestCitiesNotifier
    extends StateNotifier<SelectInterestStates> {
  final SelectInterestRepository _selectInterestRepository;

  GetSelectInterestCitiesNotifier(Ref ref)
      : _selectInterestRepository = ref.read(selectInterestRepoProvider),
        super(SelectInterestInitialState());

  Future<void> getCities() async {
    state = GetCitiesLoading();

    //Get user location if he has enabled permission.
    //else make request to enable permission
    //if denied, don't add it to the list of locations presented.
    //if user location is supported add it to the list.

    final getCitiesListOrError = await _selectInterestRepository.getCities();

    state = getCitiesListOrError.fold(
      (l) => GetCitiesFailure(l),
      (r) => GetCitiesSuccess(r),
    );
  }
}
