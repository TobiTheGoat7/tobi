part of 'select_interest_notifier.dart';

class SelectInterestStates {}

class SelectInterestInitialState extends SelectInterestStates {}

class GetListOfInterestLoading extends SelectInterestStates {}

class GetListOfInterestSuccess extends SelectInterestStates {
  final List<String> interestList;

  GetListOfInterestSuccess(this.interestList);
}

class GetListOfInterestFailure extends SelectInterestStates {
  final Failure failure;

  GetListOfInterestFailure(this.failure);
}

class GetCitiesLoading extends SelectInterestStates {}

class GetCitiesSuccess extends SelectInterestStates {
  final List<String> cities;

  GetCitiesSuccess(this.cities);
}

class GetCitiesFailure extends SelectInterestStates {
  final Failure failure;

  GetCitiesFailure(this.failure);
}

class SubmitInterestsAndCitiesLoading extends SelectInterestStates {}

class SubmitInterestsAndCitiesFailure extends SelectInterestStates {
  final Failure failure;

  SubmitInterestsAndCitiesFailure(this.failure);
}

class SubmitInterestAndCitiesSuccess extends SelectInterestStates {
  final bool status;

  SubmitInterestAndCitiesSuccess(this.status);
}
