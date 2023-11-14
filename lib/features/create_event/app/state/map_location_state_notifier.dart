import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outt/constants/helpful_functions.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/services/locationservice/location_manager.dart';
import 'package:outt/services/locationservice/models/suggestions.dart';
part 'map_states.dart';

final mapLocationNotifierProvider =
    StateNotifierProvider<MapLocationStateNotifier, MapState>((ref) {
  return MapLocationStateNotifier();
});

class MapLocationStateNotifier extends StateNotifier<MapState> {
  final Debouncer debouncer = Debouncer(milliseconds: 300);
  MapLocationStateNotifier() : super(InitialMapState());

  Future<void> getLocationFromText(String input) async {
    state = GettingMapLocation();

    try {
      debouncer.run(() async {
        List<LocationSuggestion> suggestions =
            await LocationManager.fetchSuggestions(input);
        if (suggestions.isNotEmpty) {
          state = MapLocationSuccess(suggestions[0]);
        }
      });
    } catch (ex) {
      CommonFailure failure = CommonFailure('Map Error', ex.toString());
      state = MapLocationFailure(failure);
    }
  }

  Future<void> getStreetFromLatLng(LatLng latLng) async {
    state = GettingStreetAddress(latLng);

    try {
      debouncer.run(() async {
        String address = await LocationManager.getAddressFromLatLng(latLng);
        if (address.isNotEmpty) {
          state = StreetAddressSuccess(address, latLng);
        }
      });
    } catch (ex) {
      CommonFailure failure = CommonFailure('Map Error', ex.toString());
      state = StreetAddressFailure(failure);
    }
  }
}

//make request from text editing controller.
//emit map state with location suggestions
//listen to the map state and animate map to new position
//also
// when user changes the map,
// update the map controller with the address from the map.
