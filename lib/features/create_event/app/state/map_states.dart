part of 'map_location_state_notifier.dart';

class MapState {}

class InitialMapState extends MapState {}

class GettingMapLocation extends MapState {}

class MapLocationFailure extends MapState {
  final Failure mapFailure;

  MapLocationFailure(this.mapFailure);
}

class MapLocationSuccess extends MapState {
  final LocationSuggestion firstLocationSuggestion;

  MapLocationSuccess(this.firstLocationSuggestion);
}

class GettingStreetAddress extends MapState {
  final LatLng latLng;

  GettingStreetAddress(this.latLng);
}

class StreetAddressFailure extends MapState {
  final Failure streetFailure;

  StreetAddressFailure(this.streetFailure);
}

class StreetAddressSuccess extends MapState {
  final String streetAddress;
  final LatLng latLng;

  StreetAddressSuccess(this.streetAddress, this.latLng);
}
