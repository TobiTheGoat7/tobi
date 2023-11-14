import 'dart:convert';

import 'package:geocoding/geocoding.dart' as geocode;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:outt/configs/environment.dart';
import 'package:outt/core/network_info/network_info.dart';
import 'package:outt/core/network_request/network_request.dart';
import 'package:outt/services/locationservice/models/suggestions.dart';

class LocationManager {
  //Already a singleton.
  Location location = Location();
  static final String _googleAPIkey = Environment.googleMapsAPIkey;

  LocationManager() {
    _enableLocationPermission();
  }

  Future<bool> _enableLocationService() async {
    bool serviceEnabled;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  Future<bool> _enableLocationPermission() async {
    PermissionStatus permissionGranted;

    final isLocationServiceEnabled = await _enableLocationService();
    if (!isLocationServiceEnabled) {
      return false;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    } else if (permissionGranted == PermissionStatus.deniedForever) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getCityName() async {
    LocationData? locationData;
    location.getLocation().then((value) {
      locationData = value;
    }).catchError((e) {
      throw Exception(e);
    });
    List<geocode.Placemark> placemarks = await geocode.placemarkFromCoordinates(
      locationData?.latitude ?? 0,
      locationData?.longitude ?? 0,
    );
    final place = placemarks[0];

    final currentAddress = '${place.street}, ${place.subLocality},'
        ' ${place.subAdministrativeArea}, ${place.postalCode}';

    return currentAddress;
  }

  static Future<List<LocationSuggestion>> fetchSuggestions(String input) async {
    //This search component for places focuses on Nigeria.
    final NetworkRequest networkRequest = NetworkRequestImpl();
    final NetworkInfo networkInfo = NetworkInfoImpl();
    final request =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=$_googleAPIkey';
    // The url below can be used to hard search locations
    //but this locations don't return a latlng coordinate.
    //test on postman to get correct keys.
    // 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&components=country:ng&key=$_googleAPIkey';

    final Response response;

    if (await networkInfo.isConnected) {
      response = await networkRequest.get(request);
    } else {
      throw Exception('No Network Access');
    }

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        final data = result['candidates'];

        return data
            .map<LocationSuggestion>((e) => LocationSuggestion(
                  e['name'],
                  e['formatted_address'],
                  e['geometry']['location']['lat'],
                  e['geometry']['location']['lng'],
                ))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  static Future<String> getAddressFromLatLng(LatLng latLng) async {
    List<geocode.Placemark> placemarks = await geocode.placemarkFromCoordinates(
        latLng.latitude, latLng.longitude);

    return '${placemarks[0].street}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode}, ${placemarks[0].country}';
  }
}
