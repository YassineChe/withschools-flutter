import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:withschools/configs/colors.dart';
import 'package:withschools/helpers/callback_helper.dart';
import 'package:withschools/models/callback.dart';
import 'package:withschools/models/journey.dart';
import 'package:withschools/models/tutor.dart';
import 'package:withschools/repositories/geofence_repository.dart';
import 'package:withschools/repositories/journey_repository.dart';
import 'package:withschools/services/geofencing_service.dart';
import 'package:withschools/services/location_service.dart';
import 'package:withschools/themes/map/silver.dart';
import 'package:withschools/widgets/markers/circular_marker_image_widget.dart';

class JourneyController extends GetxController {
  //@injections [private]
  JourneyRepo? _journeyRepo;
  GeofenceRepo? _geofenceRepo;
  //@injections [public]
  CallbackHelper? callbackHelper;
  LocationService? locationService = LocationService();
  GeofencingService? geofencingService = GeofencingService();
  //@instances
  Completer<GoogleMapController> googleMapController = Completer();
  //@attbiutes
  List<Journey>? journeys;
  List<Tutor>? tutors;
  //@finals
  final markers = <MarkerId, Marker>{}.obs;
  final circles = <CircleId, Circle>{}.obs;
  //@bools
  RxBool startJourney = false.obs;

  //@setters
  setStartJourney(bool value) => startJourney.value = value;

  //@constructors
  JourneyController() {
    //@init dependencies
    _journeyRepo = Get.find<JourneyRepo>();
    _geofenceRepo = Get.find<GeofenceRepo>();
    callbackHelper = Get.find<CallbackHelper>();
    //@inits lists
    journeys = List<Journey>.empty();
    tutors = List<Tutor>.empty();
  }

  @override
  void onInit() async {
    super.onInit();
    //@init location server!
    locationService?.init();

    //@ever start journey flag changes
    ever(startJourney, (status) {
      if (status) {
        //@put bus marker on map
        locationService?.getStreamCoordinate.listen((coordinate) async {
          markers[const MarkerId('bus')] = await MarkerBuilder().buildCircularImageAsset(
            markerId: const MarkerId('bus'),
            title: 'Bus',
            assetPath: 'assets/png/bus.png',
            coordinates: LatLng(coordinate.lat!, coordinate.lng!),
          );
        });
        //@start geofencing
        geofencingService?.start((geofence, geofenceRadius, geofenceStatus, location) async {
          //@geofence inter
          if (geofenceStatus == GeofenceStatus.ENTER) {
            //@post Geofence intered
            final response = await _geofenceRepo?.tryPostGeofenceEntered(
              tutorId: geofence.id,
            );

            if (response is Callback) {
              Get.snackbar(geofence.id.toString(), 'entered');
            }
          }
          //@geofence exit
          if (geofenceStatus == GeofenceStatus.EXIT) {
            //remove geofence
            geofencingService?.removeGeofence(geofenceId: geofence.id);
            //remove marker
            markers.removeWhere((key, value) => key == MarkerId(geofence.id));
            //remove circle
            circles.removeWhere((key, value) => key == CircleId(geofence.id));
          }
          //@geofence dwell
          if (geofenceStatus == GeofenceStatus.DWELL) {}
        });
      }
    });
  }

  @override
  void onReady() async {
    super.onReady();
    try {
      GoogleMapController controller = await googleMapController.future;
      controller.setMapStyle(silver);
    } catch (e) {
      return;
    }
  }

  //@get supervisor journeys
  Future<dynamic> getSupervisorJourneys() async {
    final response = await _journeyRepo?.tryGetSupervisorJourneys();

    if (response is List<Journey>) {
      journeys = response;
    }
  }

  //@get tutors of journey
  Future<dynamic> getTutorsJourneyPrepareMap({@required journeyId}) async {
    final response = await _journeyRepo?.tryGetTutorsJourney(
      journeyId: journeyId,
    );

    if (response is List<Tutor>) {
      //@clear markers
      markers.clear();
      //@foeach tutors
      for (var tutor in response) {
        MarkerBuilder()
            .buildCircularImageNetwork(
              markerId: MarkerId(tutor.id.toString()),
              title: tutor.fullName,
              imageUrl: tutor.avatar,
              coordinates: LatLng(tutor.lat!, tutor.lng!),
              onMarkerTap: () => circles.update(
                CircleId(tutor.id.toString()),
                (circle) => circle.copyWith(visibleParam: !circle.visible),
              ),
            )
            .then(
              (marker) => markers.putIfAbsent(
                MarkerId(tutor.id.toString()),
                () => marker,
              ),
            );

        //@circles radius
        circles.putIfAbsent(
          CircleId(tutor.id.toString()),
          () => Circle(
            circleId: CircleId(tutor.id.toString()),
            center: LatLng(tutor.lat!, tutor.lng!),
            radius: tutor.radius!,
            visible: false,
            fillColor: secondary.withOpacity(.5),
            strokeColor: transparent,
          ),
        );

        //@geofence points
        geofencingService?.geofenceList.add(Geofence(
          id: tutor.id.toString(),
          latitude: tutor.lat!,
          longitude: tutor.lng!,
          radius: [
            GeofenceRadius(id: 'radius', length: tutor.radius ?? 300),
          ],
        ));
      }
    }
  }
}
