import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outt/constants/constants.dart';
import 'package:outt/constants/extensions.dart';
import 'package:outt/features/common/icons/google_text.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/create_event/app/state/map_location_state_notifier.dart';
import 'package:outt/features/create_event/app/widgets/create_event_outline_box.dart';
import 'package:outt/features/create_event/models/event_address.dart';
import 'package:outt/services/locationservice/location_manager.dart';

class MapLocationAndTextField extends ConsumerStatefulWidget {
  final ValueNotifier<bool> mapExpandedNotifier;
  final ValueNotifier<EventAddress?> eventAddressNotifier;

  const MapLocationAndTextField({
    super.key,
    required this.mapExpandedNotifier,
    required this.eventAddressNotifier,
  });

  @override
  ConsumerState<MapLocationAndTextField> createState() =>
      _MapLocationAndTextFieldState();
}

class _MapLocationAndTextFieldState
    extends ConsumerState<MapLocationAndTextField> {
  bool isExpanded = false;
  late final locationNameController = TextEditingController();

  @override
  void dispose() {
    locationNameController.dispose();
    super.dispose();
  }

  void fetchLocations(String input) {
    ref.read(mapLocationNotifierProvider.notifier).getLocationFromText(input);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.mapExpandedNotifier,
        builder: (context, value, child) {
          isExpanded = value;
          return SizedBox(
            ///Adjust the width based on the existing padding.
            width: MediaQuery.of(context).size.width -
                (Constants.mainScreenPadding.left * 2),
            child: Column(
              children: [
                Row(
                  children: const [
                    NormalText(
                      'Location',
                      fontSize: 10.0,
                      textColor: Color(0xFF444242),
                    ),
                    Spacer(),
                    NormalText(
                      'Powered by',
                      fontSize: 10.0,
                      textColor: Color(0xFF444242),
                    ),
                    Gap(2.0),
                    GoogleText(),
                  ],
                ),
                const Gap(8.0),
                CreateEventOutlineBox(
                  title: 'Location',
                  child: TextFormField(
                    controller: locationNameController,
                    onChanged: fetchLocations,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Enter Location For the Event'),
                  ),
                ),
                Gap(20.0.h),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: NormalText(
                    'Location on Maps',
                    fontSize: 10.0,
                    textColor: Color(0xFF444242),
                  ),
                ),
                const Gap(8.0),
                GestureDetector(
                  onTap: () {
                    widget.mapExpandedNotifier.value = true;
                  },
                  child: AnimatedContainer(
                    width: MediaQuery.of(context).size.width,
                    //Noticed that these heights gave the best experience.
                    //The maps container below will also animate from the allowed
                    //height to the new height as well.
                    height: isExpanded
                        ? MediaQuery.of(context).size.height * 0.64
                        : 87.0.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0)),
                    clipBehavior: Clip.hardEdge,
                    duration: Constants.animationDuration,
                    child: IgnorePointer(
                        ignoring: !isExpanded,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: MapsContainer(
                            locationNameCtrl: locationNameController,
                            isMapExpanded: value,
                            eventAddressNotifier: widget.eventAddressNotifier,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class MapsContainer extends ConsumerStatefulWidget {
  final bool isMapExpanded;
  final TextEditingController locationNameCtrl;
  final ValueNotifier<EventAddress?> eventAddressNotifier;
  const MapsContainer({
    super.key,
    required this.locationNameCtrl,
    required this.isMapExpanded,
    required this.eventAddressNotifier,
  });

  @override
  ConsumerState<MapsContainer> createState() => _MapsContainerState();
}

class _MapsContainerState extends ConsumerState<MapsContainer> {
  static double lat = 6.5244;
  static double lng = 3.3792;

  @override
  void initState() {
    super.initState();
    determineDeviceLocation();
  }

  void determineDeviceLocation() async {
    final location = LocationManager().location;

    if (!kDebugMode) {
      lat = (await location.getLocation()).latitude ?? 0;
      lng = (await location.getLocation()).longitude ?? 0;
    }
  }

  CameraPosition devicePosition = CameraPosition(
    target: LatLng(lat, lng),
    zoom: 19.4746,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _addMarker(double lat, double lng, String address) {
    var markerIdVal = 'event location';
    final MarkerId markerId = MarkerId(markerIdVal);

    setState(() {
      markers = <MarkerId, Marker>{};
    });

    // creating a new MARKER
    final marker = Marker(
      markerId: MarkerId(markerIdVal),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: InfoWindow(
        title: address,
        snippet: 'Event Location',
      ),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  _updateEventAddress(double lat, double lng, String address) {
    widget.eventAddressNotifier.value =
        EventAddress(address: address, latitude: lat, longitude: lng);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(mapLocationNotifierProvider, (prev, next) async {
      if (next is MapLocationFailure) {
        next.mapFailure.showAlert(context);
      } else if (next is MapLocationSuccess) {
        _updateEventAddress(
          next.firstLocationSuggestion.latitude,
          next.firstLocationSuggestion.longitude,
          widget.isMapExpanded
              ? next.firstLocationSuggestion.description
              : widget.locationNameCtrl.text,
        );
        await goToPositionFromLatLng(
          next.firstLocationSuggestion.latitude,
          next.firstLocationSuggestion.longitude,
          next.firstLocationSuggestion.description,
        );
      } else if (next is StreetAddressSuccess) {
        widget.locationNameCtrl.text = next.streetAddress;
        _updateEventAddress(
            next.latLng.latitude, next.latLng.longitude, next.streetAddress);
        _addMarker(
            next.latLng.latitude, next.latLng.longitude, next.streetAddress);
      } else if (next is StreetAddressFailure) {
        next.streetFailure.showAlert(context);
      } else if (next is GettingStreetAddress) {
        //TODO: use an animated marker to show loading progress.
        _addMarker(next.latLng.latitude, next.latLng.longitude, '');
      }
    });

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: devicePosition,
        zoomControlsEnabled: widget.isMapExpanded,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers.values.toSet(),
        onTap: (point) {
          //set location
          ref
              .read(mapLocationNotifierProvider.notifier)
              .getStreetFromLatLng(LatLng(
                point.latitude,
                point.longitude,
              ));
        },
      ),
    );
  }

  Future<void> goToPositionFromLatLng(double lat, double lng,
      [String? address]) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition newPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 17.4746,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));
    _addMarker(lat, lng, address ?? '');
  }
}
