import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:get/get.dart';
import 'package:withschools/models/coordinate.dart';
import 'package:withschools/models/mqtt.dart';
import 'package:withschools/repositories/mqtt_respository.dart';
import 'package:withschools/services/mqtt_service.dart';
import 'dart:async';
//@configs & heplers
import '/configs/colors.dart';
import '/helpers/callback_helper.dart';
//@models
import '/models/callback.dart';
import '/models/journey.dart';
import '/models/tutor.dart';
//@repositories
import '/repositories/geofence_repository.dart';
import '/repositories/journey_repository.dart';
//@services
import '/services/geofencing_service.dart';
import '/services/location_service.dart';
//@themes
import '/themes/map/silver.dart';
//@widgets
import '/widgets/markers/circular_marker_image_widget.dart';

class JourneyController extends GetxController {
  //@injections [private]
  JourneyRepo? _journeyRepo;
  GeofenceRepo? _geofenceRepo;
  MqttRepo? _mqttRepo;
  //@injections [public]
  CallbackHelper? callbackHelper;
  LocationService? locationService = LocationService();
  GeofencingService? geofencingService = GeofencingService();
  MqttService? mqttService = MqttService();
  Coordinate _coordinate = Coordinate();
  //@instances
  Completer<GoogleMapController> googleMapController = Completer();
  //@attbiutes
  List<Journey>? journeys;
  List<Tutor>? tutors;
  //@finals
  final markers = <MarkerId, Marker>{}.obs;
  final circles = <CircleId, Circle>{}.obs;
  final box = GetStorage();
  //@vars
  RxBool fingerUsed = false.obs;
  double zoom = 12;
  int? selectedJourneyId;
  //@setters
  setFingerUsed(bool value) => fingerUsed.value = value;
  sertZoom(double value) => zoom = value;
  //@getters
  RxBool get getFingerUsed => fingerUsed;
  double get getZoom => zoom;
  int? get getSelectedJourneyId => selectedJourneyId;
  double get getSchoolLat => double.parse(box.read('lat') ?? '0.0');
  double get getSchoolLng => double.parse(box.read('lng') ?? '0.0');

  //@constructors
  JourneyController() {
    //@init dependencies
    _journeyRepo = Get.find<JourneyRepo>();
    _geofenceRepo = Get.find<GeofenceRepo>();
    _mqttRepo = Get.find<MqttRepo>();
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

    //@get supervisor mqtt
    final response = await _mqttRepo?.tryGetSupervisorMqtt();

    //@check mqtt response
    if (response is Mqtt) {
      //@init mqtt
      mqttService?.init(
        username: response.username,
        password: response.password,
      );

      //@put bus marker on map
      locationService?.getStreamCoordinate.listen((coordinate) async {
        //set a global coordinate (incase want to access to current position)
        _coordinate = coordinate;

        //@buses moved
        markers[const MarkerId('bus')] = await MarkerBuilder().buildCircularImageAsset(
          markerId: const MarkerId('bus'),
          title: 'Autobus',
          assetPath: 'assets/png/bus.png',
          coordinates: LatLng(coordinate.lat!, coordinate.lng!),
        );

        //@move camera with bus
        if (getFingerUsed.isFalse) {
          await googleMapController.future.then(
            (value) => value.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: zoom,
                  target: LatLng(coordinate.lat!, coordinate.lng!),
                ),
              ),
            ),
          );
        }

        //@publish mqtt with current coordinates
        mqttService?.publish(
          topic: 'topic',
          message: {'lat': coordinate.lat, 'lng': coordinate.lng},
        );
      });
    }
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
  Future<dynamic> startJourney({@required journeyId}) async {
    final response = await _journeyRepo?.tryGetTutorsJourney(
      journeyId: journeyId,
    );

    if (response is List<Tutor>) {
      //store localy this selected ID
      selectedJourneyId = journeyId;
      //@clear markers & circles & geofences
      markers.removeWhere((markerId, marker) => markerId != const MarkerId('bus'));
      circles.clear();
      geofencingService?.geofenceList.clear();
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

      //@start geofencing
      geofencingService?.start((geofence, geofenceRadius, geofenceStatus, location) async {
        //@geofence inter
        if (geofenceStatus == GeofenceStatus.ENTER) {
          Get.snackbar('title', 'message');
          //@post Geofence intered
          final response = await _geofenceRepo?.tryPostGeofenceEnterTutor(
            tutorId: int.parse(geofence.id),
            journeyId: selectedJourneyId,
          );

          if (response is Callback) {
            // Get.snackbar(geofence.id.toString(), 'entered');
          }
        }

        // @geofence dwell
        if (geofenceStatus == GeofenceStatus.DWELL) {
          final response = await _geofenceRepo?.tryPostGeofenceDwellTutor(
            tutorId: int.parse(geofence.id),
            journeyId: selectedJourneyId,
          );

          if (response is Callback) {
            // Get.snackbar(geofence.id.toString(), 'dwell');
          }
        }

        // @geofence exit
        if (geofenceStatus == GeofenceStatus.EXIT) {
          //remove geofence
          geofencingService?.removeGeofence(geofenceId: geofence.id);
          //remove marker
          markers.removeWhere((key, value) => key == MarkerId(geofence.id));
          //remove circle
          circles.removeWhere((key, value) => key == CircleId(geofence.id));
        }
      });
    }
  }

  //@stop joruney
  void stopJourney() {
    selectedJourneyId = null;
    geofencingService?.geofenceList.clear();
    geofencingService?.geofenceService.clearAllListeners();
    geofencingService?.geofenceService.stop();
    markers.removeWhere((markerId, marker) => markerId != const MarkerId('bus'));
    circles.clear();
  }

  //@focus on the bus
  void focusOnBus() async {
    if (_coordinate.lat != null && _coordinate.lng != null) {
      await googleMapController.future.then(
        (value) => value.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: zoom,
              target: LatLng(_coordinate.lat!, _coordinate.lng!),
            ),
          ),
        ),
      );
    }
  }
}
