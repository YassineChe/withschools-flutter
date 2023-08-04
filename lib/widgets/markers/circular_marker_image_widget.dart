import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_marker/marker_icon.dart';

class MarkerBuilder {
  //@constructor
  MarkerBuilder();

  //@this will build a circular image as marker
  Future<Marker> buildCircularImageNetwork({
    @required MarkerId? markerId,
    @required String? title,
    @required String? imageUrl,
    @required LatLng? coordinates,
    VoidCallback? onMarkerTap,
    VoidCallback? onInfoWindowTap,
  }) async {
    return Marker(
      onTap: onMarkerTap,
      markerId: markerId!,
      position: coordinates!,
      anchor: const Offset(0.5, 0.5),
      // consumeTapEvents: true,
      infoWindow: InfoWindow(
        title: title,
        onTap: onInfoWindowTap,
      ),
      icon: await MarkerIcon.downloadResizePictureCircle(
        imageUrl!,
        size: 90,
        addBorder: true,
        borderColor: Colors.white,
        borderSize: 10,
      ),
    );
  }

  //@this will build a circular image as marker
  Future<Marker> buildCircularImageAsset({
    @required MarkerId? markerId,
    @required String? title,
    @required String? assetPath,
    @required LatLng? coordinates,
    VoidCallback? onMarkerTap,
    VoidCallback? onInfoWindowTap,
  }) async {
    return Marker(
      onTap: onMarkerTap,
      markerId: markerId!,
      position: coordinates!,
      anchor: const Offset(0.5, 0.5),
      // consumeTapEvents: true,
      infoWindow: InfoWindow(
        title: title,
        onTap: onInfoWindowTap,
      ),
      icon: await MarkerIcon.pictureAsset(assetPath: assetPath!, width: 90, height: 90),
    );
  }
}
