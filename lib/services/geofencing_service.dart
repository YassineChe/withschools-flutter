import 'dart:async';
import 'package:geofence_service/geofence_service.dart';

class GeofencingService {
  //* INSTANCES *************************/
  final geofenceStreamController = StreamController<Geofence>();
  final activityStreamController = StreamController<Activity>();
  final geofenceList = <Geofence>[];

  //? Geofence instance & and step
  final geofenceService = GeofenceService.instance.setup(
    interval: 1000,
    accuracy: 100,
    loiteringDelayMs: 60000,
    statusChangeDelayMs: 10000,
    useActivityRecognition: true,
    allowMockLocations: false,
    printDevLog: false,
    geofenceRadiusSortType: GeofenceRadiusSortType.DESC,
  );

  //@init function
  Future<void> start(
    Future<void> Function(
      Geofence geofence,
      GeofenceRadius geofenceRadius,
      GeofenceStatus geofenceStatus,
      Location location,
    ) onGeofenceStatusChanged,
  ) async {
    //* Add Geofence service
    geofenceService.addGeofenceStatusChangeListener(onGeofenceStatusChanged);
    //* Start Geofence service
    geofenceService.start(geofenceList);
  }

  //@remove geofence
  void removeGeofence({String? geofenceId}) {
    geofenceList.removeWhere((element) => element.id == geofenceId);
  }
}
