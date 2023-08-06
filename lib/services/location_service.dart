import 'dart:async';
import 'package:geolocator/geolocator.dart';
//@models
import '/models/coordinate.dart';

class LocationService {
  //@instances
  StreamSubscription<Position>? positionStream;
  StreamController<Coordinate> streamController = StreamController<Coordinate>.broadcast();
  //@getters
  Stream<Coordinate> get getStreamCoordinate => streamController.stream;

  void init() async {
    //@configuration
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );

    //@start listen to current location
    positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position? position) {
      streamController.add(
        Coordinate(lat: position?.latitude, lng: position?.longitude),
      );
    });
  }
}
